#!/bin/bash

set -e

if [[ -z $1 ||  -z $2 ]]; then
	echo "
		this scrpt requires 2 parameters
		\$1 REMOTE_MACHINE_USERNAME i.e: root (just kiding, not root pleas)
		\$2 REMOTE_MACHINE_IP_OR_HOSTNAME i.e: 192.168.0.1"
	exit;
fi

REMOTE_MACHINE_ALIAS="mainframer-server"
REMOTE_MACHINE_USERNAME=$2
REMOTE_MACHINE_IP_OR_HOSTNAME=$3

#ssh key is generated if not there yet
if [ ! -f ~/.ssh/mainframer ]; then
	mkdir -p ~/.ssh
	chmod u+rw,go= ~/.ssh
	ssh-keygen -f ~/.ssh/mainframer 
fi;

#config is added to ssh config
#TODO need to check for duplication
echo "Host $REMOTE_MACHINE_ALIAS
  User $REMOTE_MACHINE_USERNAME
  HostName $REMOTE_MACHINE_IP_OR_HOSTNAME
  Port 22
  IdentityFile ~/.ssh/mainframer
  PreferredAuthentications publickey
  ControlMaster auto
  ControlPath /tmp/%r@%h:%p
  ControlPersist 1h


" >> ~/.ssh/config

#central home mainframer configuration
echo "remote_machine=$REMOTE_MACHINE_ALIAS" > ~/.mainframer

#create a executable
sudo mv mainframer /usr/local/bin/mainframer
sudo chmod +x /usr/local/bin/mainframer

echo "Copy the next key and send to the server guy


"
#print the last generated ssh key
cat ~/.ssh/mainframer.pub

