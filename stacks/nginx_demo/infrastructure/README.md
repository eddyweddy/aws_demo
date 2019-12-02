Terraform scripts to create a basic VPC, subnet and other wiring to allow internet access.

Pre-requirements
Access to a Terraform binary, I used 
+ Terraform v0.12.17
+ provider.aws v2.40.0 (This will be downloaded by terraform)

Direct access to an aws account from the command line. Lets assume awscli and credentials have been set up.
Your aws cli is attached to an IAM role that can create and destroy stuff :)

Run instructions
+ terraform init
+ terraform plan -var-file=../configuration/dev.tfvars -out=tf.plan
+ terraform apply tf.plan

Cleanup 
+ Make sure any EC2s are removed first
+ terraform destroy -var-file=../configuration/dev.tfvars


View what you have made
+ terraform show

