# Create Projects
oc new-project tasks-build --display-name="Tasks - BUILD"
oc new-project tasks-dev --display-name="Tasks - DEV"
oc new-project tasks-test --display-name="Tasks - TEST"
oc new-project tasks-prod --display-name="Tasks - PROD"
oc new-project cicd-dev --display-name="CI/CD - DEV"

# Grant Jenkins Access to Projects
#oc policy add-role-to-group edit system:serviceaccounts:cicd-dev -n tasks-build
#oc policy add-role-to-group edit system:serviceaccounts:tasks-build -n tasks-dev
#oc policy add-role-to-group edit system:serviceaccounts:tasks-build -n tasks-test
#oc policy add-role-to-group edit system:serviceaccounts:tasks-build -n tasks-prod
oc policy add-role-to-user edit system:serviceaccount:cicd-dev:jenkins -n tasks-build
oc policy add-role-to-user edit system:serviceaccount:cicd-dev:jenkins -n tasks-dev
oc policy add-role-to-user edit system:serviceaccount:cicd-dev:jenkins -n tasks-test
oc policy add-role-to-user edit system:serviceaccount:cicd-dev:jenkins -n tasks-prod

oc policy add-role-to-group system:image-puller system:serviceaccounts:tasks-build -n cicd-dev
oc policy add-role-to-group system:image-puller system:serviceaccounts:tasks-dev -n cicd-dev
oc policy add-role-to-group system:image-puller system:serviceaccounts:tasks-test -n cicd-dev
oc policy add-role-to-group system:image-puller system:serviceaccounts:tasks-prod -n cicd-dev

# Deploy Demo
oc new-app -n cicd-dev jenkins-persistent
oc new-app -n tasks-build -f /root/rhocp_homework/yaml/cicd-template.yaml

# Waiting for project to complete  and then Start Pipeline
oc project tasks-build
echo "Waiting for cicd-demo-installer to complete..."
sleep 30
while [ ! `oc get pod | grep 'cicd-demo-installer.*Completed' | awk '{print $1}'` ]; do
   echo "..."
   sleep 30
done

echo `oc get pod | grep 'cicd-demo-installer.*Completed'`
echo "Starting Pipeline: tasks-pipeline..."
oc start-build tasks-pipeline

# sleep for 10 minutes to allow pipeline to finish
sleep 600
oc set resources dc/tasks --requests=cpu=100m -n tasks-prod
oc autoscale dc/tasks --min 1 --max 5 --cpu-percent=80 -n tasks-prod
oc rollout latest tasks -n tasks-prod
