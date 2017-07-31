#!/bin/sh

PULL='git pull'
ROOTPATH=$PWD
REPOGITBIKEBSP=${ROOTPATH}
REPOGITPOKY=${ROOTPATH}/poky-morty
REPOGITOPENEMBEDDED=${REPOGITPOKY}/meta-openembedded
REPOGITQT5=${REPOGITPOKY}/meta-qt5
REPOGITRASPBERRY=${REPOGITPOKY}/meta-raspberrypi
REPOGITRPI=${ROOTPATH}/rpi/meta-rpi

for i in $(set -o posix; set|grep "REPOGIT" |cut -f2 -d "=");do
    tput setaf 3
    echo Updating "${i}..."
    tput sgr 0
    cd ${i}
    $PULL origin 
    cd $ROOTPATH
done

