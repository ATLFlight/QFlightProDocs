#!/bin/bash
aclocal
autoconf
automake -a
./configure --host=x86_64-ubuntu-linux-gnu
