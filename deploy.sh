#!/bin/bash -x

#to execute on a CI/CD platform.
#requirements: kubectl, terraform cli, docker

terraform init
terraform plan
terraform apply

docker image build . --tag belong-app:latest

kubectl apply -f ./kubernetes/deployment.yaml
kubectl apply -f ./kubernetes/service.yaml
