#Get App URL and generate load using curl
ROUTE="http://"$(oc get route hello-openshift --template "{{ .spec.host }}")
for time in {1..15000}
do
  echo time $time
  curl ${ROUTE}
done
