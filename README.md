# Sparks debian (ubuntu) amd64 / x86 package build

This is alpha stage build for Debian Package. Main goal is creating an easy to install
package for coins with masternode capability. Configs, sentinal, systemd, boostrap auto install
scripts are included.


## deb_pkg structure

### sparkscore-0.12.3.x [package name-version]

#### template
* coinpkg/systemd
* coinpkg/rootsuer
* coinpkg/sysuser
* coinpkg/conf_rpcuser
* coinpkg/conf_rpcpwd
* coinpkg/conf_extip
* coinpkg/msg_wrong_user
* coinpkg/git_bootstrap
* coinpkg/git_sentinel

#### control
self speaking - Depends **important**

#### postinst

* Fetching configuration from debconf
* checking if user is root 
  **[ if then homeDIR is /root not /home/$username ]**
* setting the coin specific targets 
  **[ example = coinname ]**
* check if user wants to install systemd.service 
  **[ sed *vars* on opt/$coin_name/etc/$coin_daemon"_"username.service and copy it to /etc/systemd/system/$coin_name.service ]**
* check if sparks.conf is existing in users homeDIR/.sparkscore 
  **[ sed *vars* on opt/$coin_name/configs/$coin_config_file and copy it to $coin_config_folder/$coin_config_file ]**
* check if masternode.conf is existing in suers homeDIR/.sparkscore
  **[ cp /opt/$coin_name/configs/masternode.conf $coin_config_folder/ ]**
* if boostrap install is wanted downloading from git
* if sentinel is wanted downloaded from git and installed to $coin_config_folder
* if sentinel is wanted also crontab is installed to $username
* last but not least setting the OWNER to $coin_config_folder


#### prerm

* checking if sparksd is running
* checking if systemd is installed
* if sparksd.service is existing -> STOP it
* removing cronjob from user

#### postrm
self speaking


# TODO LIST
* code beautify
* set *vars* to global with db_set
* write x86 package
* changelog
* dependencies check
* manpage creation
