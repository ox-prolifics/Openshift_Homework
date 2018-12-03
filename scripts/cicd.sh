# Create Projects
oc new-project task-build --display-name="Tasks - BUILD"
oc new-project task-dev --display-name="Tasks - DEV"
oc new-project task-test --display-name="Tasks - TEST"
oc new-project task-prod --display-name="Tasks - PROD"
oc new-project cicd-dev --display-name="CI/CD - DEV"

# Grant Jenkins Access to Projects
oc policy add-role-to-group edit system:serviceaccounts:cicd-dev -n task-build
oc policy add-role-to-group edit system:serviceaccounts:cicd-dev -n task-dev
oc policy add-role-to-group edit system:serviceaccounts:cicd-dev -n task-test
oc policy add-role-to-group edit system:serviceaccounts:cicd-dev -n task-prod

# Deploy Demo
oc new-app jenkins-persistent
oc new-app -n cicd-dev -f /root/rhocp_homework/yaml/cicd-template.yaml

# Waiting for project to complete  and then Start Pipeline
oc project cicd-dev
echo "Waiting for cicd-demo-installer to complete..."
while [ ! `oc get pod | grep 'cicd-demo-installer.*Completed' | awk '{print $1}'` ]; do
   sleep 30
done

echo `oc get pod | grep 'cicd-demo-installer.*Completed'`
echo "Starting Pipeline: tasks-pipeline..."
oc start-build tasks-pipeline

# sleep for 10 minutes to allow pipeline to finish
sleep 600
oc set resources dc/tasks --requests=cpu=100m -n task-prod
oc autoscale dc/tasks --min 1 --max 5 --cpu-percent=80 -n task-prod
oc rollout latest tasks -n task-prod
