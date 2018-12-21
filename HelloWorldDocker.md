# Using the Qualcomm Flight Pro Docker SDK for development

** NOTE: The docker image that is required to build apps for the Qualcomm Flight Pro NOT YET available. Please return to this page later. **

The docker container is an alternative to building on target. It allows for native ARM SW builds in an emulated environment.

Table of Contents
=================
- [Run docker image](#run-docker-image)
- [Build hello example](#build-hello-example)
- [Download to target](#download-to-target)
- [Query and update packages](#query-and-update-packages)
- [Common docker commands](#common-docker-commands)

## Run docker image

Make sure you are running Ubuntu 16.04 or 14.04 with the kernel updated to the Xenial kernel (see [here](https://wiki.ubuntu.com/Kernel/LTSEnablementStack#Ubuntu_14.04_LTS_-_Trusty_Tahr)).

```
./scripts/run_docker.sh ${docker-image-url-or-path}
```

The above command will:
- Pull the docker image
- Create a home directory named sdk_home in the current directory and map it as the home directory inside the container
- Map the scripts directory to /opt/scripts directory inside the container (There is a script here to add the host addresses to the /etc/hosts file)
- Create an interactive bash inside the docker.

The container will run as the same user ID that invoked the command above. 

The container will run /bin/bash and anything that is created in the home directory will be accessible in the future. Data stored elsewhere will be purged when the container exits.

If you run uname you will see that the Docker container is running an ARM userspace:
```
uname -a
```

## Build hello example inside the docker shell

The examples directory is mapped to /opt/examples in the Docker image.

### CMake
To build the cmake example:
```
cd /opt/examples/cross_compile/cmake
rm -rf build
mkdir build
cd build
cmake ..
make
```

### Autotools
_NOTE_ The SDK does not yet support native autotools.

To build the autotools example:

```
cd /opt/examples/cross_compile/autotools
./bootstrap.sh
make
```

## Download to target

First copy the files from docker to Linux home directory (sdk_home).
```
cd /opt
cp -r examples/cross_compile ~/.
```

Next, connect the Qualcomm Flight Pro board to the computer via USB. Next steps will push files from Linux home directory to Excelsior using adb.

In the hello example there is only one file each to upload for cmake:
```
cd sdk_home/cross_compile/cmake/build
adb devices
adb push hello /home/root/hello_cmake
```

Similarly for autotools

```
cd sdk_home/cross_compile
adb push autotools /home/root/hello_autotools
```

You can now open a terminal and access shell on the target (Qualcomm Flight Pro board) and run the files.
```
adb shell
cd /home/root
./hello_cmake
./hello_autotools
```

## Common docker commands
``` docker image list ```  
``` docker image rm ```

To pull down a docker image:  
```docker pull atl-docker.com/project/excelsior/<image>:latest```  
For example:  
```docker pull atl-docker.com/project/excelsior/excelsior-arm-sdk-sprint130:latest```  

