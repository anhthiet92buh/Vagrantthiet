#!/bin/bash
kubectl aplly -f ./phoenix/postgres-pv.yaml
kubectl aplly -f ./phoenix/postgres-pvc.yaml
helm install mydb ./postgresql-ha/ --set persistence.existingClaim=postgresql-pv-claim --set volumePermissions.enabled=true