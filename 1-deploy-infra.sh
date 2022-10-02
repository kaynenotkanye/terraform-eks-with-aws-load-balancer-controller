#!/bin/bash

terraform init
terraform plan
terraform apply --auto-approve

# Give some time for k8s to do it's thing...
# Auto-generate kubeconfig for kubectl/helm commands
sleep 30
aws eks --region us-west-2 update-kubeconfig --name eks-bottlerocket-imnr
# Validation of kubeconfig -- run get nodes command
kubectl get nodes
