#!/bin/bash

pkgs='sudo ufw fail2ban'
if ! dpkg -s $pkgs >/dev/null 2>&1; then
  sudo apt-get install $pkgs
fi


sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw allow 8890/tcp
sudo ufw logging on
sudo ufw enable
