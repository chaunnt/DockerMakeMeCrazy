# DockerMakeMeCrazy
DockerMakeMeCrazy

docker system prune -a --volumes

sudo docker rmi -f $(sudo docker images -f "dangling=true" -q)
#sudo docker rm $(sudo docker ps --filter "status=exited" -q)
#docker volume ls -qf dangling=true | xargs -r docker volume rm
docker system df -v

#docker image prune


