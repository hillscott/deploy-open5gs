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
exit
# Open5GS Prep
cd ~
sudo apt install git vim
git clone 'https://github.com/Borjis131/docker-open5gs.git'
# TODO: 
# Set the host to a static IP of the NAT IP assigned (10.0.2.15/24 gw: 10.0.2.2) dns 9.9.9.9
#
# TODO:
# Extract the active IP instead of assuming it
# 
sed -i 's/DOCKER_HOST_IP=.*/DOCKER_HOST_IP=10.0.2.15/' ~/docker-open5gs/.env
# Docker + Docker compose setup
sudo apt -y install docker-compose docker-compose-v2 docker-buildx
cd ~/docker-open5gs
#Even make needs root in order to connect to the docker daemon
sudo make base-open5gs
if [[ $? -ne 0 ]]; then
	log "Non 0 exit code from make detected. Bailing out..."
	exit
fi
log "BUILD SUCCESS!"
log "Proceeding with Docker compose..."
# Example using the basic deployment
sudo docker compose -f compose-files/basic/docker-compose.yaml --env-file=.env up -d
if [[ $? -ne 0 ]]; then
	log "Non 0 exit code from make detected. Bailing out..."
	exit
fi

# To shutdown instances... 
log "BUILD COMPLETE!"
log "To Shutdown instances use: sudo docker compose -f compose-files/basic/docker-compose.yaml stop"
# Read docs here: https://github.com/Borjis131/docker-open5gs/blob/main/docs/configuration.md (Database configuration)
