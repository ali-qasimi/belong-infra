# belong-infra-terraform

### Challenge Scenario: <br>
As the platform/systems team, we have been asked to deliver a standard secure infrastructure on our AWS Cloud Account with following requirements.

### Infra Requirements:
• A dedicated VPC with public and private subnets. <br>
• A server in the private subnet running httpd as a service. The time zone of the server should be set to AEST. <br>
• Download the file belong-test.html from S3 Bucket (belong-coding-challenge) in Sydney region and service it through httpd running as a service on the server. <br>
• Developers require terminal access to the server for further configuration / administration. <br>

### Solution Overview: <br>
• Terraform has been used to provision the infrastructure including EKS cluster, EKS node group, IAM roles and policies, VPC, private subnets, public subnet along with Internet gateway and route table, security groups, ssh keys etc. Note that the provider configuration is set to accommodate for testing on Localstack. <br>
• Kubernetes deployment, NodePort and Ingress Controller ALB provisioning. <br>
• Dockerfile to bake the application image along with its dependencies <br>
• Shell script to provision the Terraform infrastructure, build the docker image and deploy the Kubernetes resources. <br>

### Setup: <br>
• Requirements: Terraform v1.0.9, Localstack 0.12.19.1, kubectl v1.24.3, Docker v20.10.9, Bash terminal. <br>
• To deploy the infrastructure, run `./deploy.sh`
