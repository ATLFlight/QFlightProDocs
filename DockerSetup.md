A docker image will be provided in order to enable apps development for the Qualcomm Flight Pro platform.

## Download
The docker image is NOT yet available for download. It will be available *later*.

## Setup
This section will describe how to setup the docker container for apps development WHEN it is available.

## Usage
To develop apps using the docker image, please see [Building Hello World in a Docker](HelloWorldDocker.md).

## Troubleshooting and FAQ
- Remove running docker containers
```
docker ps -a
docker stop <container ID>
```
- Clean up local docker images
```
docker image list
docker rmi <image ID>
```
- List all containers (only IDs) ```docker ps -aq```  
- Stop all running containers. ```docker stop $(docker ps -aq)```  
- Remove all containers. ```docker rm $(docker ps -aq)```  
- Remove all images. ```docker rmi $(docker images -q)```  
- BAD_CREDENTIAL error when pulling down the docker image from the URL
```
docker pull <URL>
Using default tag: latest
Error response from daemon: Get https://<URL>/<image-name>/manifests/latest: unauthorized: BAD_CREDENTIAL
```  
Solution: Logout and then login again:  
```
docker logout atl-docker.qualcomm.com
docker login atl-docker.qualcomm.com
docker pull <URL>/<image-name>
```

## References
- Switching docker workspaces: https://linuxconfig.org/how-to-move-docker-s-default-var-lib-docker-to-another-directory-on-ubuntu-debian-linux
- Start, stop and restart docker: https://github.com/boot2docker/boot2docker/issues/782
- http://blog.baudson.de/blog/stop-and-remove-all-docker-containers-and-images
