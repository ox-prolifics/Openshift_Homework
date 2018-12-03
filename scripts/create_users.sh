#!/bin/bash

users=(Amy Andrew Brian Betty Chris Cody)
for u in "${users[@]}" 
do
   echo "Creating user: $u"
   htpasswd -db /etc/origin/master/htpasswd $u r3dh4t1!
done

echo "Creating admin user..."
htpasswd -db /etc/origin/master/htpasswd admin admin

echo "Adding admin as Cluster admin"
# oc adm policy add-cluster-role-to-user cluster-admin admin
