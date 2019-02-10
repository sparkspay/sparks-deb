#!/bin/bash

rsync -av $1/DEBIAN/ $1-amd64/DEBIAN/ --exclude control
rsync -av $1/DEBIAN/ $1-i386/DEBIAN/ --exclude control

dpkg-deb --build $1-i386
dpkg-deb --build $1-amd64


## purge the debconf for testing purpose
#sudo echo PURGE | debconf-communicate sparkscore
