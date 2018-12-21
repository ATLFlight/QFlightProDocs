# Cross Compilation with the Qualcomm Flight Pro SDK

## Setup the environment

Install CMake 3.3.0 or higher and add it to your path.

Set the environment variables:

Set the location to where the SDK will be installed:
export SDKROOT=\<sdk-install-location>  
ex.
```export SDKROOT=/local/mnt/workspace/excelsior-sdk```

Set the location of the SDK installer:  
export SDKINSTALLER=\<sdk-installer-location>  
the location should be the directory where it has the SDK installer  
ex.  if the location is  /local/mnt/workspace/images/sdk/, it should contains  
```
oecore-x86_64-aarch64-toolchain-nodistro.0.host.manifest
oecore-x86_64-aarch64-toolchain-nodistro.0.target.manifest
oecore-x86_64-aarch64-toolchain-nodistro.0.sh
```  
Set the following environment variable:  
```export SDKINSTALLER=/local/mnt/workspace/images/sdk```  

## Installing the SDK

The SDK is part of the latest release builds
```
mkdir ${SDKROOT}
${SDKINSTALLER}/oecore-x86_64-aarch64-toolchain-nodistro.0.sh -y -D -d ${SDKROOT}
source ./scripts/sdk-fixup.sh ${SDKROOT}
```

The scripts to set the environment are incorrect for multiarch in Yocto Jethro. A new script is created named _environment-setup-armv7a-vfp-oemllib32-linux_ that is consistent with the toolchain.
The sdk-fixup.sh script creates this file.


## Setup workspace environement for building 32-bit applications 
The current SDK only supports building 32-bit application.

```. ${SDKROOT}/environment-setup-armv7a-vfp-oemllib32-linux```   
OR
```source ${SDKROOT}/environment-setup-armv7a-vfp-oemllib32-linux```


## Test the environment

### CMake
Install CMake and add it to your path.
```
cd examples/cross_compile/cmake
make cross
```

### Autotools
```
cd examples/cross_compile/autotools
./bootstrap-cross.sh
make
```
