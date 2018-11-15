#!/usr/bin/env bash

sudo -i
oc new-project smoke-test
oc new-app nodejs-mongo-persistent
sleep 300
while [ ! `oc get pod | grep complete` ]; do
   sleep 60
done