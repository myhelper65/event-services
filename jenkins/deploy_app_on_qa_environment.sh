echo 'Deploying App on Kubernetes'
envsubst < k8s/eventservice_chart/values-template.yaml > k8s/eventservice_chart/values.yaml
sed -i s/HELM_VERSION/${BUILD_NUMBER}/ k8s/eventservice_chart/Chart.yaml
AWS_REGION=$AWS_REGION helm repo add stable-eventservice s3://eventservice-helm-charts-tecitlab.org/stable/myapp/ || echo "repository name already exists"
AWS_REGION=$AWS_REGION helm repo update
helm package k8s/eventservice_chart
AWS_REGION=$AWS_REGION helm s3 push --force eventservice_chart-${BUILD_NUMBER}.tgz stable-eventservice
kubectl create ns eventservice-qa || echo "namespace eventservice-qa already exists"
kubectl delete secret regcred -n eventservice-qa || echo "there is no regcred secret in eventservice-qa namespace"
kubectl create secret generic regcred -n eventservice-qa \
    --from-file=.dockerconfigjson=/var/lib/jenkins/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
AWS_REGION=$AWS_REGION helm repo update
AWS_REGION=$AWS_REGION helm upgrade --install \
    eventservice-app-release stable-eventservice/eventservice_chart --version ${BUILD_NUMBER} \
    --namespace eventservice-qa