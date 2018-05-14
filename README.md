# Terraform_AWS_wordpress

![architecture diagram 1](https://github.com/leeadh/Terraform_AWS_wordpress/blob/master/architecture_diagram.jpg)


To run 
1) First go to the provider file and fill in the secret and access key of your account. 
2) Please note that this is using AP-Southeast-1. Do change if you want to use other regions
3) After this cd to directory and then perform following steps
- terraform init
- terraform plan
- terraform apply

Please note that a better design should be where the rds is launched in the private instead of the public subnets. In this case you would need to create a nat gateway to direct traffic from the public to private subnets. 
