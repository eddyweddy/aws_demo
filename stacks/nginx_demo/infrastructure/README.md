Terraform scripts to create a basic VPC, subnet and other wiring to allow internet access.


Run instructions
+ terraform init
+ terraform plan -var-file=../configuration/dev.tfvars -out=tf.plan
+ terraform apply tf.plan

Cleanup 
+ Make sure any EC2s are removed first
+ terraform destroy -var-file=../configuration/dev.tfvars


View what you have made
+ terraform show

