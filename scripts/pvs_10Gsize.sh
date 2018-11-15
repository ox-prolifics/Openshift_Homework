#!/usr/bin/env bash

export GUID=`hostname|awk -F. '{print $2}'`
export volsize="10Gi"
export GUID=`hostname|awk -F. '{print $2}'`
echo "export GUID=$GUID" >> ~/.bashrc
echo 'export volsize="10Gi"'
echo $GUID

scp /root/homework/create_pvs.sh support1.$GUID.internal

ssh support1.$GUID.internal
sudo -i
mkdir -p /srv/nfs/user-vols/pv{1..200}

for pvnum in {1..50} ; do
echo /srv/nfs/user-vols/pv${pvnum} *(rw,root_squash) >> /etc/exports.d/openshift-uservols.exports
chown -R nfsnobody.nfsnobody  /srv/nfs
chmod -R 777 /srv/nfs
done

ansible nfs -a "systemctl restart nfs-server"