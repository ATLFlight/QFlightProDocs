#!/bin/bash



IMAGE=$1
docker images ${IMAGE} | grep ${IMAGE} || docker pull ${IMAGE}

mkdir -p sdk_home
docker run --rm -it --privileged -e LOCAL_USER_ID=`id -u` \
        -e LOCAL_USER_NAME=`echo ${USER}` -e LOCAL_GID=`id -g` \
        -v `pwd`/sdk_home:/home/${USER}:rw \
        -v `pwd`/scripts:/opt/scripts:rw \
        -v `pwd`/examples:/opt/examples:rw \
        ${IMAGE} /bin/bash

