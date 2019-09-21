# terraform-jekins

This project will provide a simples installation of jenkins ina EC2 machine. After this you will have a empty jenkins to configurate your projects. This project uses the deafult VPC provide by AWS.

Prerequisites
--------

Create your account in AWS and user(IAM) and get the secret and token keys

[IAM Credentials](https://docs.aws.amazon.com/cli/latest/reference/iam/create-access-key.html)

Also get your VPC ID in this [link](https://us-east-2.console.aws.amazon.com/vpc/home?region=us-east-2#vpcs:sort=VpcId) and alter this line `vpc_id      = "vpc-ceb4a8a6"` on main.tf in aws_security_group resource

## Install terraform

[TERRAFORM](https://learn.hashicorp.com/terraform/getting-started/install.html)


## Configure AWS CLI

[INSTALL](https://docs.aws.amazon.com/cli/latest/userguide/install-linux-al2017.html)
[CONFIGURE](https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-chap-configure.html)

`
aws configure
AWS Access Key ID [None]: <YOUT_SECRET>
AWS Secret Access Key [None]: <YOUT_ACCESS_KEY>
Default region name [None]: us-east-2
Default output format [None]: 
`

RUN TERRAFORM
--------

To validade this code with terraform run a PLAN command in your terminal

`terraform plan`

To create the resources run a terraform APPLY

`terraform apply`

*this command will create the resources at your account and can result in charges on your card

To remove the resources run a terraform DESTROY

`terraform destroy`

## Run Project

`git clone https://github.com/krismorte/terraform-jenkins.git`

`cd terraform-jenkins.git`

`terraform init`

`terraform apply -auto-approve`


## Outputs

| Name | Description |
|------|-------------|
| jenkis-ssh | Command to access ec2 command line |
| jenkis-url | Url to access your jenkins |

## Jenkins
Using the ssh output command to get the initial password to start jenkins configuration

..but firts change the permission on generated ssh key

`chmod 400 key.pem`

and get the key using the ssh command like this below

`ssh -i key.pem ec2-user@ec2-18-191-167-107.us-east-2.compute.amazonaws.com sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

you can follow this [link](https://jenkins.io/doc/book/installing/) to finalize the configuration
