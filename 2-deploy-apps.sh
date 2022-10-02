#!/bin/bash

AWS_REGION=us-east-2
EKS_CLUSTER_NAME=eks-bottlerocket-imnr
ACCOUNT_ID=$(aws sts get-caller-identity | grep Arn | awk -F: '{print $6}')

aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

# If helm chart is already cached, comment out the next line
#helm install stackstorm-aks stackstorm/stackstorm-ha

helm upgrade --install \
    stackstorm-aks stackstorm/stackstorm-ha \
    --namespace stackstorm \
    --create-namespace \
    --wait

eksctl utils associate-iam-oidc-provider \
    --region $AWS_REGION \
    --cluster $EKS_CLUSTER_NAME \
    --approve

helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
    --set clusterName=$EKS_CLUSTER_NAME \
    --namespace kube-system \
    --set serviceAccount.create=true \
    --set serviceAccount.name=aws-load-balancer-controller

# Validate the service account got created...
kubectl get serviceaccounts -n kube-system | grep aws-load-balancer-controller
sleep 30

# Create k8s namespace for the 2048 game
kubectl create namespace 2048-game

# Deploy helm charts for 2048
kubectl apply -f ./2048
