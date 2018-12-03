#!/usr/bin/env bash

echo "Creating project..."
oc new-project smoke-test >/dev/null 2>&1
echo "Creating App..."
oc new-app nodejs-mongo-persistent >/dev/null 2>&1
echo "Waiting for complete..."
while [ ! `oc get pod | grep Complete` ]; do
   sleep 30
done
test=`oc status | grep http: | awk '{print $1}'`
echo $test
if `curl $test >/dev/null 2>&1`; then  
   echo "Smoketest passed"
else 
   echo "Smoketest failed"
   exit 1
fi
