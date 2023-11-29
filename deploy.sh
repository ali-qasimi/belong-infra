#!/bin/bash -x

#to execute on a CI/CD platform.
#requirements: kubectl, helm, terraform cli, docker

cd terraform
terraform init
terraform plan
terraform apply

cd ..
docker image build . --tag belong-app:latest

kubectl apply -f ./kubernetes/deployment.yaml
kubectl apply -f ./kubernetes/service.yaml

helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
kubectl create namespace ingress-nginx
helm install nginx-controller ingress-nginx/ingress-nginx --namespace nginx-ingress

kubectl apply -f ./kubernetes/ingress.yaml
