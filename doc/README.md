# Sparks debian (ubuntu) amd64 [ i386 is not tested ]

This is beta stage build for Debian Package. Main goal is creating an easy to install
package for coins with masternode capability. Configs, sentinel, systemd, boostrap auto install 
scripts are included.


## signed package
Because this package is in beta stage it is not signed and not available on a public mirror.
If you are afraid of installing it you can download the coins installation package and 
compare the checksums

### boostrap && sentinel
Because the block sync is timeconsumptive the maintainer is offering a boostrap file for
download. You can deside your self if you want to use it or not. Sentinel is requiring
python virtual environment so we desided to configure it as package dependency.

### crontab autoinstall
You have the choise to use autoinstall of sentinel -> the configured user ( ie. root ) gets
an autoatic installation of sentinel wich is also downloaded and maintained by the coindevs.

## FREE to USE
Because this packages are under the license of OpenGl and the masternode-programms mostly under 
MIT licence you are free to use -> share -> modify. As a so called "one man show" I would
appreciate to get informed on modifications or forks.

I'm willing to learn from others! New coins will be supported on requests.

## Installation
Check the docs folder


## Donation
If you want to donate -> you are welcome

sparks = GX6S6icvknCzXrjpCQdTKwzNuxBCCByVVV
