

rm -Rf src/sparksqt-0.12.4.2-{amd64,i386}/usr/*
mkdir src/sparksqt-0.12.4.2-{amd64,i386}/usr/bin

rm -Rf src/sparkscore-0.12.4.2-{amd64,i386}/usr/*

cp -R ../sparkscore-0.12.4_i386/* src/sparkscore-0.12.4.2-i386/usr/
cp -R ../sparkscore-0.12.4_x64/* src/sparkscore-0.12.4.2-amd64/usr/

mv src/sparkscore-0.12.4.2-i386/usr/bin/sparks-qt src/sparksqt-0.12.4.2-i386/usr/bin/
mv src/sparkscore-0.12.4.2-amd64/usr/bin/sparks-qt src/sparksqt-0.12.4.2-amd64/usr/bin/

rm src/sparkscore-0.12.4.2-i386/usr/bin/test_sparks
rm src/sparkscore-0.12.4.2-amd64/usr/bin/test_sparks
