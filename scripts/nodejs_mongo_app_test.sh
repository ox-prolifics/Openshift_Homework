#!/usr/bin/env bash

test=`oc status | grep http: | awk '{print $1}'`
echo $test
if `curl $test >/dev/null 2>&1`; then  
   echo "Smoketest1 passed"
else 
   echo "Smoketest1 failed"
   exit 1
fi

test2="http://nodejs-mongo-persistent-smoke-test.apps.example.opentlc.com"
if `curl $test2 >/dev/null 2>&1`; then  
   echo "Smoketest2 failed"
   exit 1
else 
   echo "Smoketest2 passed"
fi
