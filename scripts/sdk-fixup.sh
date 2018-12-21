#!/bin/bash

SDKROOT=$1

if [ "${SDKROOT}" = "" ]; then
    echo "Usage $0 sdkroot"
    exit 1
fi

if [ ! -f ${SDKROOT}/environment-setup-armv7a-vfp-oemllib32-linux ]; then
   cp ${SDKROOT}/environment-setup-armv7a-vfp-neon-oemllib32-linux-gnueabi ${SDKROOT}/environment-setup-armv7a-vfp-neon-oemllib32-linux
   mv ${SDKROOT}/environment-setup-armv7a-vfp-neon-oemllib32-linux-gnueabi ${SDKROOT}/environment-setup-armv7a-vfp-neon-oemllib32-linux-gnueabi.orig
   sed -i -e "s/arm-oemllib32-linux-gnueabi/arm-oemllib32-linux/" ${SDKROOT}/environment-setup-armv7a-vfp-neon-oemllib32-linux
#sed -i -e '/^export CC=/s/"$$/ -B\$$\{SDKROOT\}\/sysroots\/aarch64-oe-linux\/usr\/lib\/arm-oemllib32-linux-gnueabi\/4.9.3"/' sdk/environment-setup-armv7a-vfp-oemllib32-linux
   rm -f ${SDKROOT}/environment-setup-armv7a-vfp-neon-oemllib32-linux-gnueabi
   pushd ${SDKROOT}
   ln -s environment-setup-armv7a-vfp-neon-oemllib32-linux environment-setup-armv7a-vfp-neon-oemllib32-linux-gnueabi
   popd

   # The compiler search path is wrong
   pushd ${SDKROOT}/sysroots/aarch64-oe-linux/usr/lib/
   ln -s arm-oe-linux arm-oe-linux-gnueabi
   popd
fi
echo "SDK fixed"
