kubectl delete -f ./phoenix/postgres-pvc.yaml
kubectl delete -f ./phoenix/postgres-pv.yaml
helm uninstall mydb