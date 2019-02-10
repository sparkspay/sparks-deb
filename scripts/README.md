# Things you should always mention!

- secure system
- secure network
- secure ssh
- secure rpc

## Secure system
The masternode can run as root, but for security reasons owners
should always create a user per coin and masternode. A compromised masternode can harm the user but mostly not the full system or other coin/masternodes. **Be shure to follow this rule!**

```sh
[root@masternode]$ adduser mnuser
Adding user 'mnuser' ...
Adding new group 'mnuser' (1001) ...
Adding new user 'mnuser' (1001) with group 'mnuser' ...
Creating home directory '/home/mnuser' ...
Copying files from '/etc/skel' ...
Enter new UNIX password: << your pwd here >>
Retype new UNIX password: << your pwd here >>
passwd: password updated successfully
Changing the user information for mnuser
Enter the new value, or press ENTER for the default
	Full Name []: 
	Room Number []: 
	Work Phone []: 
	Home Phone []: 
	Other []: 
Is the information correct? [Y/n]

[root@masternode]$ adduser mnuser sudo
Adding user 'mnuser' to group 'sudo' ...
Adding user mnuser to group sudo
Done.

```

## Secure network
The Linux Package ufw allows you to secure your ports and network with iptables without having big knowledge about iptables scripting. In combination with fail2ban your ssh is also monitored and this is a good begining of network security!

```sh
[root@masternode]$ apt-get install ufw fail2ban
[root@masternode]$ ./ufw.sh

```
ufw.sh
```sh

#!/bin/bash

sudo ufw default allow outgoing     #allow all outgoing
sudo ufw default deny incoming      #deny all incoming
sudo ufw allow ssh/tcp              #allow the ssh port (22)
sudo ufw limit ssh/tcp              #limit the ssh port (for fail2ban)
sudo ufw allow 8890/tcp             #allow Sparks - MN Port (8890)
sudo ufw logging on                 #loggin on
sudo ufw enable                     #start the engine

```

### Info
Some VPS-Provider use OpenVz for virtualization, the iptables on these systems are very tricky and could make some problems -> when you enable the ufw and your ssh session gets kicked -> talk to your provider [they have to fix it!] 
 

 
## Secure ssh
As mentioned before use fail2ban to ban malicious hosts trying to guess your password - but even better don't allow root to auth to ssh session. Connect as normal user ad sudo/su to root. Be aware that if you don't configure a user and dissalow root access to ssh you can reach your system only via recovery console!

1. add user (mnuser)
2. disallow root login on ssh
3. keep your root shell after restart sshd
4. login as user (see if it works)
5. close root session

@2 don't forget to keep this session open after restart sshd
```sh
[root@masternode]$ nano /etc/ssh/sshd_config
....
#PermitRootLogin prohibit-password
StrictModes yes
....
[root@masternode]$ sytemctl restart sshd
```

@4 if this works well you can try a sudo
```sh
[user@homepc]$ ssh mnuser@mymasternode.xyz
....
[mnuser@masternode]$ sudo su    #user password
or
[mnuser@masternode]$ su -       #root password
```

## Secure rpc  
Never ever configure RPC ports to bind on public ip if you don't know what it is for. If you need to open the access configure ufw to allow only one IP or IP-RANGE for connection purpose.

Ie. **multiple client** servers and **one master** server which is calling the rpc-api of the others.

1. strong rpcpassword for each client different [rpcpassword]
2. untypical rpcuser for each client different [rpcuser]
3. untypical rpcport [rpcport]
4. allow only masterip for rpc-calls [rpcallowip]
5. ufw port forward to localip is better than bind to public [rpcbindip]

### Info
If your host/user gets compromised the user can't rewrite your ufw rules to allow his host to connect to rpc-localhost-portforward. The person which is on your masternode can rewrite the config but can't access because firewall drops his/her ip!
