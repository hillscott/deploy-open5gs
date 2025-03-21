## ⚠️ Disclaimer  
The scripts in this repository are meant to take a brand new Ubuntu 24.04 Install, and turn it into a fully functional Dokerized Open5GS Stack. It is *strongly* recommended that you do this in a VM. **MANY** packages will be installed as part of the installation process, and any existing Docker / Open5GS Installations will almost certainly end up broken if they already exist. 

The script will also run a **FULL Ubuntu OS Update wherever you run it** Again...
Do **NOT** Run this on your main Ubuntu 24.04 day-to-day workstation. Use a VM. **You have been warned.**

Also: The Dockerized Open5GS installation has many default 100% *insecure* settings. Only use this stack for educational purposes unless and until you are able to modify most if not *all* default settings. 

# deploy-open5gs
This repository serves as a means to automate and explain a Dockerized Open5GS installation. It provides a way for someone who has limited knowledge of how to interact with Ubuntu Linux or Docker, a means to utilize the excellent code provided by other repositories, including:
* [docker-open5gs](https://github.com/Borjis131/docker-open5gs.git) (Provides most of the components required for a functional Open5GS server <-> client setup)
* [PacketRusher](https://github.com/HewlettPackard/PacketRusher) (Used to add a necessary kernel module to your Ubuntu host)
* [open5gs](https://github.com/open5gs/open5gs) (Already included in the docker-open5gs repository mostly, but we use it for MongoDB manipulation and to add a test client (aka UE in the 5G terminology)

It has only been tested with Ubuntu 24.04 and is unlikely to work on other platforms without modifcation. The main code lives in docker-service_setup.sh - the remainder of the repository will provide documentation for how to:
* Use the script (see 🛠️ Usage)
* Issue some basic ```docker``` and ```docker compose``` commands to interact with the Open5GS stack
* Provide some background on the various Open5GS components (which each live in their own container) and their terminology

## Why Docker?
Docker containers take advantage of the NFV (Network Function Virtualization) present in 5G networks, to provide you the flexibility to keep each 5g component in an isolated environment, without the overhead associated with full virtualization. That's just one reason though, here are some more:
* If you want to use this repository to split your 5g network across multiple docker hosts, you can do that - just make some edits to the Docker compose files.
* If you want to look at the logs for _just_ the AMF function, that's easy - just use the docker logs command described in COMMANDS.md to pull those logs.
* If you want to see the network traffic flow just to the AMF Docker container, that's easy - just capture traffic from the network interface for that container.
There are many benefits to docker, but if you want to take the deployment further, Kubernetes deployment configurations are also available in the [docker-open5gs](https://github.com/Borjis131/docker-open5gs.git) repository.  

## Why Open5gs?
Do you want to understand how 5G networks work? There's no better way than to build your own. This repository, and the repositories already referenced will allow you to do that. If you want to connect your deployment up to a real eNodeB / gNodeB (Basestation), supported hardware is here: [Tested Hardware - Open5gs](https://open5gs.org/open5gs/docs/hardware/01-genodebs/). Bear in mind that this script creates a deployment with 0 security. As per the disclaimer, you would need to make _many_ changes to use this deployment in production.

## Requirements
* An Ubuntu 24.04 VM with 30GB of disk space. The entire stack (including Ubuntu) will take ~15GB. 
* 4-8 vCPUs
* 8-12GB RAM allocated to the VM

## 🛠️ Usage
After git cloning the repository locally...
```
chmod u+x ./docker-service_setup.sh
./docker-service_setup.sh
```
The script will prompt you to confirm the IP address you would like to use for the Docker installation. This should be your local IP address. It will automatically detect it in most cases, but you are able to override the auto-detection if necessary. 

Once the IP address is confirmed, it will begin a full Operating System update, prior to continuing with the Dockerized Open5GS stack setup and all of the necessary components. The build will take a long time, depending on your hardware and network connection. At the end, you will be provided with a means to test the installation. Documentation linked here will also discuss that. 

## Docs
See: 
* [COMMANDS.md](./COMMANDS.md)
* [CONFIGS.md](./CONFIGS.md)
* [BACKGROUND.md](./BACKGROUND.md)

## References
See [BACKGROUND.md](./BACKGROUND.md)
