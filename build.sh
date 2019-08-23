#!/usr/bin/env bash

# >>> Set this (for ROOT version):
VERSION="v5-34-38"
# root versions: https://root.cern.ch/releases

# >>> And this (for PyROOT v2 or v3):
PYTHON="/usr/bin/python3"

#---------------------------------------------

ROOT=$(pwd)
SRC=$(pwd)/src
BUILD=$(pwd)/build
INSTALL=$(pwd)/$VERSION
PY_VERSION=$($PYTHON --version 2>&1 | awk '{print $2}' | awk -F '.' '{print $1"."$2}')

printf " >> Checking for root git repository.. "
if [ ! -d $SRC ]
then
    printf "not found, installing..\n"
    git clone http://github.com/root-project/root.git src || \
    exit 1
else
    printf "found\n"
fi

cd $SRC
if [ "$(git branch | grep \* | cut -d ' ' -f2)" == "$VERSION" ]
then
    printf " >> %s branch checked out, continuing.. \n" $VERSION
else 
    printf " >> Checking out $VERSION branch.." && \
    git checkout -b $VERSION $VERSION && \
    cd $ROOT || \
    exit 1
fi
cd $ROOT

echo
echo " >> Making build and install directories.."
[ ! -d $BUILD ] && mkdir $BUILD
[ ! -d $INSTALL ] && mkdir $INSTALL

echo " >> Clearing build and install directories.."
cd $INSTALL && \
rm -rf *
cd $BUILD && \
rm -rf *

printf "\n\n >> Configuring and setting options..\n\n"
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL -DPYTHON_EXECUTABLE=$PYTHON -D all:BOOL=ON $SRC && \
printf "\n\n >> Building root using %d cores\n\n" $(grep -c ^processor /proc/cpuinfo) && \
cmake --build .  --target install -- -j$(grep -c ^processor /proc/cpuinfo) && \
printf "\n\n >> Installing root.. \n\n" && \
cmake -P cmake_install.cmake && \
printf "\n\n >> Removing build directory.. \n\n" && \
cd $ROOT && \
rm -rf $BUILD && \
printf "\n\n >> Adding alias to .bashrc: %s='source %s/bin/thisroot.sh\n\n" $VERSION $INSTALL && \
printf "\n# To activate ROOT version: %s\nalias %s='source %s/bin/thisroot.sh'\n" $VERSION $VERSION $INSTALL >> ~/.bashrc && \
printf "\n# note: PyROOT has been built for python %s\n" ${PY_VERSION} && \
printf "Finished successfully!\n\n"

