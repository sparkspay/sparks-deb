#!/bin/bash

#dpkg-deb --build $1-i386
## download src

mkdir -p src/bin
mkdir -p src/build
mkdir -p src/download

rm -Rf src/bin/*
rm -Rf src/build/*

if [ $# -eq 0 ] 
then 
	echo "no Versionnumber given!!"
	exit 
fi

url_i686="https://github.com/sparkspay/sparks/releases/download/v"$1"/"
url_pi2="https://github.com/sparkspay/sparks/releases/download/v"$1"/"
url_amd64="https://github.com/sparkspay/sparks/releases/download/v"$1"/"

file_i686="sparkscore-"$1"-i686-pc-linux-gnu.tar.gz"
file_pi2="sparkscore-"$1"-RPi2.tar.gz"
file_amd64="sparkscore-"$1"-x86_64-linux-gnu.tar.gz"

function download(){
  if [[ -e $1 ]] 
	then 
		echo 'file exists'
  	else

		"wget" $2$1
  fi
}

pushd ./src/download

download $file_i686 $url_i686
download $file_pi2 $url_pi2
download $file_amd64 $url_amd64

mkdir -p unzip/{i686,amd64,pi2}
tar xvzf $file_i686 -C unzip/i686
tar xvzf $file_amd64 -C unzip/amd64
tar xvzf $file_pi2 -C unzip/pi2

pushd ./unzip/
for i in $(ls)
do
	mv $i/sparkscore* ../../bin/$1-$i
done
popd
rm -Rf unzip
popd

## working
rm -R ./src/build/*
mkdir -p ./src/build/{sparkscore,sparksqt}-$1-{amd64,i686,pi2}

## sync template
rsync -av ./src/template/sparkscore-template/ ./src/build/sparkscore-$1-amd64/
rsync -av ./src/template/sparkscore-template/ ./src/build/sparkscore-$1-i686/
rsync -av ./src/template/sparkscore-template/ ./src/build/sparkscore-$1-pi2/

rsync -av ./src/template/sparksqt-template/ ./src/build/sparksqt-$1-amd64/
rsync -av ./src/template/sparksqt-template/ ./src/build/sparksqt-$1-i686/
rsync -av ./src/template/sparksqt-template/ ./src/build/sparksqt-$1-pi2/



pushd ./src/bin
for i in $(ls)
do
	mkdir -p ../build/sparkscore-$i/usr
	#cp -R $i/* ../build/sparkscore-$i/usr/
	rsync -av $i/* ../build/sparkscore-$i/usr/ 
	##hack touch bench_sparks
	touch ../build/sparkscore-$i/usr/bin/bench_sparks
	rm ../build/sparkscore-$i/usr/bin/{test_sparks,bench_sparks}

	if [[ $i =~ .*pi2.* ]]
	then
		echo 'PI has no QT'
	else
		#create bin dir and move sparks-qt 
		mkdir -p ../build/sparksqt-$i/usr/bin
		mv ../build/sparkscore-$i/usr/bin/sparks-qt ../build/sparksqt-$i/usr/bin/sparks-qt
	fi
done
popd

## sparks has no raspberry pi qt 
rm -Rf ./src/build/sparksqt*pi2*


# changeLOG should be done automatic!


pushd ./src/build
## configure the package confs and build it

rm ./deb/*
for i in $(ls)
do
	arch=$(echo $i | awk -F- '{print $NF}' | sed 's/pi2/armhf/g')
	dirsize=$(du -s $i/usr | cut -f1)
	sed -i 's/<version>/'$1'/g' ./$i/DEBIAN/control
	sed -i 's/<arch>/'$arch'/g' ./$i/DEBIAN/control
	sed -i 's/<size>/'$dirsize'/g' ./$i/DEBIAN/control
	dpkg-deb --build $i
done
popd

## move the debian packages to deb folder
mv ./src/build/*.deb ./src/deb/

### cleanup
rm -Rf ./src/build/*
rm -Rf ./bin/*
