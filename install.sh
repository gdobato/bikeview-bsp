#!/bin/sh

INSTALL='apt-get install'
CLONE='git clone'
POKYPATH=poky-morty
ROOTPATH=./
RPIPATH=rpi
BUILDPATH=${RPIPATH}/build
TOOLCHAINPATH=${ROOTPATH}/tools/toolchain/
CONFPATH=conf
SDKPATH=/opt/poky/2.2.2

##################################################
#
#  Help functions
#
##################################################
progress() {
  pid=$!
  sp='>'
  tput setaf $2
  echo ""
  echo $1
  while kill -0 $pid  > /dev/null 2>&1
  do
      printf '%s' "$sp"
      sleep 0.5
  done

}

errorReport() {
  tput setaf 1
  echo ""
  echo "error!: $1"
  echo ""
  tput sgr 0
  exit 1
}

success() {
  tput setaf 2
  echo ""
  echo "done"
  echo ""
  tput sgr 0
}

cleanterminal() {
  tput sgr 0
  echo ""
  echo ""
  echo ""
}

title() {
  tput setaf 3
  echo ------------------------------------------
  echo " $1"
  echo ------------------------------------------
  tput sgr 0
}

head() {
  tput setaf 6
  echo ------------------------------------------
  echo ""
  echo "       BIKEVIEW - BSP                   "
  echo ""
  echo ------------------------------------------
  tput sgr 0
}

##################################################
#
#  Main functions
#
##################################################

installPackages(){
  title "Install needed packages"
  sudo $INSTALL build-essential chrpath diffstat gawk git libncurses5-dev pkg-config subversion texi2html texinfo python2.7
}

linkPython(){
  title "Set default python version to 2.7"
  sudo ln -sf /usr/bin/python2.7 /usr/bin/python 
  sudo dpkg-reconfigure dash
}

clonePoky(){
  title "Cloning poky repositories"
  $CLONE git@gitlab.com:bikeview/poky-morty.git  
  cd $POKYPATH
  $CLONE git@gitlab.com:bikeview/meta-openembedded.git
  $CLONE git@gitlab.com:bikeview/meta-qt5.git
  $CLONE git@gitlab.com:bikeview/meta-raspberrypi.git
  cd ..
}

cloneRPi(){
  title "Cloning raspberry-Pi repository"
  $CLONE git@gitlab.com:bikeview/meta-rpi.git
}

#It does not work inside script
#ToDo: Look for a solution to set the environment by using scripts
environment(){
  source poky-morty/oe-init-build-env rpi/build
}

cloneSDK(){
  title "Cloning Toolchain-SDK"
  $CLONE git@gitlab.com:bikeview/tools.git
}

installSDK(){
  title "Installing Toolchaing - SDK ..."
  ${TOOLCHAINPATH}/poky-glibc-x86_64-meta-toolchain-qt5-armv5e-toolchain-2.2.2.sh
}



##################################################
#
#  Main routine
#
##################################################

head 
cleanterminal
installPackages && success
linkPython && success
if [ ! -d $POKYPATH ]; then
  clonePoky && success
else
  errorReport "poky-morty directory already exists"  
fi

if [ ! -d $RPIPATH ]; then
  mkdir -p ${BUILDPATH}
  cp -Rf ${CONFPATH} ${BUILDPATH}/conf
  cd $RPIPATH 
  cloneRPi && success
  cd ..
else
  errorReport "rpi directory already exists"  
fi
if [ ! -d $SDKPATH ]; then
  cloneSDK && success
  installSDK && success
else
  echo "Toolchain-SDK already installed"
  echo "Installation cancelled"
fi


