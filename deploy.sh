#!/bin/bash -x

#to execute on a CI/CD platform.
#requirements: kubectl, terraform cli, docker

cd terraform
terraform init
terraform plan
terraform apply

cd ..
docker image build . --tag belong-app:latest

kubectl apply -f ./kubernetes/deployment.yaml
kubectl apply -f ./kubernetes/service.yaml
kubectl apply -f ./kubernetes/ingress.yaml
