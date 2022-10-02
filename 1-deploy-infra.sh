#!/bin/bash

terraform init
# If terraform.tfstate exists, copy it here...
cp ~/artifacts/terraform.tfstate
terraform plan
terraform apply --auto-approve

# Give some time for k8s to do it's thing...
# Auto-generate kubeconfig for kubectl/helm commands
sleep 30
aws eks --region us-east-2 update-kubeconfig --name eks-bottlerocket-imnr
# Validation of kubeconfig -- run get nodes command
kubectl get nodes

# Send to artifacts folder
# NOTE: In a real-world project, we would be putting tfstate in S3
cp terraform.tfstate ~/artifacts/