#!/usr/bin/env bash

echo "Copy a new hosts file to /etc/ansible/hosts"
cp /root/rhocp_homework/hosts /etc/ansible/hosts

# exports GUID line to .bashrc only once even if run multiple times
if ! grep --quiet GUID /$HOME/.bashrc; then 
   export GUID=`hostname | cut -d"." -f2`; echo "export GUID=$GUID" >> $HOME/.bashrc
fi

source $HOME/.bashrc

echo "Set the current GUID to generate the inventory"
#sed -i "s/GUID/$GUID/g" /etc/ansible/hosts
mv /etc/ansible/hosts /etc/ansible/hosts.bak; sed 's/GUID/'$GUID'/g' /etc/ansible/hosts.bak > /etc/ansible/hosts
rm -rf /etc/ansible/hosts.bak
ansible all -m shell -a 'export GUID=`hostname | cut -d"." -f2`; echo "export GUID=$GUID" >> $HOME/.bashrc'
