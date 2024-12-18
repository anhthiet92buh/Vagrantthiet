helm repo add bitnami https://charts.bitnami.com/bitnami
kubectl create namespace kubeapps
helm install kubeapps --namespace kubeapps bitnami/kubeapps --set frontend.service.type=NodePort
#helm uninstall kubeapps --namespace kubeapps


bitnami/postgresql-repmgr
bitnami/pgpool
bitnami/postgres-exporter
bitnami/os-shell

kubectl create --namespace default serviceaccount kubeapps-operator

kubectl create clusterrolebinding kubeapps-operator --clusterrole=cluster-admin --serviceaccount=default:kubeapps-operator

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: kubeapps-operator-token
  namespace: default
  annotations:
    kubernetes.io/service-account.name: kubeapps-operator
type: kubernetes.io/service-account-token
EOF

kubectl get --namespace default secret kubeapps-operator-token -o go-template='{{.data.token | base64decode}}'