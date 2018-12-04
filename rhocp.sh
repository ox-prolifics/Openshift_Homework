#!/bin/bash

chmod +x scripts/*
temp=$1
if [ "$1" = "uninstall" ]; then
    ansible-playbook /root/rhocp_homework/yaml/cleanup.yaml | tee /var/log/rhocp_uninstall.log
elif [ "$1" = "install" ]; then
   ansible-playbook /root/rhocp_homework/yaml/homework.yaml | tee /var/log/rhocp_install.log
elif [ "$1" = "clean" ]; then
   ansible-playbook /root/rhocp_homework/yaml/cleanup.yaml | tee /var/log/rhocp_uninstall.log
   ansible-playbook /root/rhocp_homework/yaml/homework.yaml | tee /var/log/rhocp_install.log
else
   echo "please provide option: uninstall, install, or clean"
fi
