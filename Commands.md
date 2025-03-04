## Common Commands
Note that anything in [brackets] indicates that you should replace that block with the name of what you're trying to interact with.
You can get the name of Docker containers by using the first command listed (after the stack is built).
```sudo docker ps --no-trunc```
* Show all of the running containers AND the full BEGIN line (which includes the configuration file used by the Daemon in the Container)
```sudo docker compose -f ~/docker-open5gs/compose-files/internal/packetrusher/docker-compose.yaml --env-file=.env up -d```
* If you stopped or downed the stack previously, this is how you bring it all back up. Note that it won't rebuild images all over again assuming that they are still present. So this goes quick after the first build. 
```sudo docker compose -f ~/docker-open5gs/compose-files/internal/packetrusher/docker-compose.yaml --env-file=.env stop```
* STOP all of the containers. This is like powering things off.
```sudo docker compose -f ~/docker-open5gs/compose-files/internal/packetrusher/docker-compose.yaml --env-file=.env down```
* DOWN the containers and networks. This is like powering things off, and then deleting all of the LIVE containers. You can still bring up fresh copies with up though. 
```sudo docker volume ls```
* See the extra MongoDB containers that docker-open5gs will create
```sudo docker volume rm [mongo-volume-to-remove]```
* If you want to fully start over... after doing a down, you'll also need to do this. 
```sudo docker exec -it [instance] bash```
* ENTER into a container.
```sudo docker logs [instance]```
* Look at the logs associated with the container's service. 
```sudo docker stop/start [instance]```
* Stop / Start an individual container.
```~/open5gs/misc/db/open5gs-dbctl showall```
* Display the contents of the MongoDB Database (where clients are stored)
