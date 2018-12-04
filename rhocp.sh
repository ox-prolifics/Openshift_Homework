#!/bin/bash

chmod +x scripts/*
temp=$1
if [ "$1" = "uninstall" ]; then
    ansible-playbook /root/rhocp_homework/yaml/cleanup.yaml
elif [ "$1" = "install" ]; then
   ansible-playbook /root/rhocp_homework/yaml/homework.yaml
elif [ "$1" = "clean" ]; then
   ansible-playbook /root/rhocp_homework/yaml/cleanup.yaml
   ansible-playbook /root/rhocp_homework/yaml/homework.yaml
else
   echo "please provide option: uninstall, install, or clean"
fi
