#!/bin/bash
# WORK-IN-PROGRESS!
# Author: Ian Reynolds
# This script is used to automate the fantastic docker-open5gs code from https://github.com/Borjis131/docker-open5gs.git
# deployment within an Ubuntu 24.04 environment.
# It is designed to be used in concert with other scripts under active development.
log() {
	echo "LOG: $1"
}
has_sudo_access() {
	log "This script either needs root or sudo access. Testing..."
	if [[ $EUID -ne 0 ]]; then
		log "Testing sudo..."
		sudo ls /root &>/dev/null
		if [[ $? -ne 0 ]]; then
			log "sudo usage failed! Check that this user can sudo!"
			exit
		fi
	fi
	log "Access checks passed."
}
has_sudo_access
sudo apt update
sudo apt -y upgrade
if [[ -f /var/run/reboot-required ]]; then
	log "Ending the script here to allow for a clean OS upgrade."
	log "Re-run this script after you have rebooted."
	exit
fi
# Open5GS Prep
cd ~
sudo apt install git vim wget
git clone 'https://github.com/Borjis131/docker-open5gs.git'
# TODO: 
# Set the host to a static IP of the NAT IP assigned (10.0.2.15/24 gw: 10.0.2.2) dns 9.9.9.9
#
# TODO:
# Extract the active IP instead of assuming it
# 
sed -i 's/DOCKER_HOST_IP=.*/DOCKER_HOST_IP=10.0.2.15/' ~/docker-open5gs/.env
# Docker + Docker compose setup
sudo apt -y install docker-compose docker-compose-v2 docker-buildx make
cd ~/docker-open5gs
#Even make needs root in order to connect to the docker daemon
sudo make base-open5gs
if [[ $? -ne 0 ]]; then
	log "Non 0 exit code from make detected. Bailing out..."
	exit
fi
log "BUILD SUCCESS!"
log "Setting up Kernel Module for PacketRusher"
cd ~
sudo apt install gcc
# Installed kernel module from directions here: https://github.com/HewlettPackard/PacketRusher
git clone https://github.com/HewlettPackard/PacketRusher 
cd PacketRusher && echo "export PACKETRUSHER=$PWD" >> $HOME/.profile
source $HOME/.profile
cd $PACKETRUSHER/lib/gtp5g
make clean && make && sudo make install

log "Setting up Mongosh for UE Adding"
# Install mongosh from https://www.mongodb.com/try/download/shell
cd ~; wget https://downloads.mongodb.com/compass/mongodb-mongosh_2.4.0_amd64.deb
sudo dpkg -i ./mongodb-mongosh_2.4.0_amd64.deb


log "Proceeding with Docker compose..."
# Example using the packetrusher deployment
cd ~; sudo docker compose -f ./docker-open5gs/compose-files/internal/packetrusher/docker-compose.yaml --env-file=./docker-open5gs/.env up -d
if [[ $? -ne 0 ]]; then
	log "Non 0 exit code from make detected. Bailing out..."
	exit
fi

log "Setting up Open5gs DB Editor"
cd ~; git clone 'https://github.com/open5gs/open5gs'
# Note using https://github.com/open5gs/open5gs/blob/main/misc/db/README.md to look at the db
# Default slice selection doesn't work with "add" - it's set to nothing when you add a subscriber but it should be 000001 for sd
./open5gs/misc/db/open5gs-dbctl add_ue_with_slice 001011234567891 00000000000000000000000000000000 00000000000000000000000000000000 "internet" 1 000001

log "Stopping and Starting packetrusher"
sudo docker stop packetrusher
sudo docker start packetrusher

# To shutdown instances... 
log "BUILD COMPLETE!"
log "To Shutdown instances use: sudo docker compose -f compose-files/basic/docker-compose.yaml stop"
log "Run: sudo docker logs packetrusher"
log "It should show 'You can do traffic for this UE using VRF....'"
log "If it does, you are ready to start generating UE traffic"
log "sudo docker exec -it packetrusher bash"
log "(from within the packetrusher container)"
log "ip vrf exec vrf1234567891 bash"
log "(from within the vrf)"
log "ping 9.9.9.9"
log "(packet captures will show all of the steps of the simulated UE traffic going through the 5g workflow)"
# Read docs here: https://github.com/Borjis131/docker-open5gs/blob/main/docs/configuration.md (Database configuration)
