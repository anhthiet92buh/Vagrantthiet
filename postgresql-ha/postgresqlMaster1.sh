#!/bin/bash
kubectl apply -f ./phoenix/postgres-pv.yaml
kubectl apply -f ./phoenix/postgres-pvc.yaml
helm install mydb ./sql-ha/ --set persistence.existingClaim=postgresql-pv-claim+