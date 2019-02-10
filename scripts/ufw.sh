#!/bin/bash

sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh/tcp
sudo ufw limit ssh/tcp
sudo ufw allow 8890/tcp
sudo ufw logging on
sudo ufw enable