#!/bin/bash

# Added bigger sleep to let StackStorm settle down and ALB/TargetGroups to get created
sleep 60

helm test stackstorm-aks --namespace stackstorm
export ST2CLIENT=$(kubectl get --namespace stackstorm pod -l app=st2client,release=stackstorm-aks -o jsonpath="{.items[0].metadata.name}")
kubectl exec -it ${ST2CLIENT} --namespace stackstorm -- st2 execution list
