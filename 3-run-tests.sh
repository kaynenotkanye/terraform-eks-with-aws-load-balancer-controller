#!/bin/bash

helm test stackstorm-aks --namespace stackstorm
sleep 5
export ST2CLIENT=$(kubectl get --namespace stackstorm pod -l app=st2client,release=stackstorm-aks -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it ${ST2CLIENT} --namespace stackstorm -- st2 execution list
