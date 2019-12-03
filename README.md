# Demo Terraform stack in AWS with Ansible bootstrap

Creates a Infrastructure stack in AWS using terraform.
The resulting instance(s) are configured using Ansible

### Pre-requirements
Access to a Terraform binary, I used 
+ Terraform v0.12.17
+ provider.aws v2.40.0 (This will be downloaded by terraform)
+ Ansible 2.6.5 (at least)
+ Python 2.7.16 (Python 3 might not work)
+ aws cli
+ Your own key pair in AWS

Direct access to an aws account from the command line. Lets assume awscli and credentials have been set up, and your aws cli is attached to a provisioning IAM role that can create and destroy stuff :)

Once you have a keypair, please replace any occurrence of "dev-nonprod.pem" with your own private key to allow ssh to work.
That should be in
+ Common/scripts/ansible.cfg
+ stacks/build/roles/provision/vars/main.yml
+ stacks/nginx_demo/infrastructure/service-docker.tf

Once you are done, Just do this to kick off the stack creation
```bash
./create_demo_stack.sh
``` 

As there is only one instance, this isnt a high availability scenario

To verify, you can run

```bash
./test/word_count.py <load balancer public DNS>
``` 
This script is used for counting the occurrence of words on the default nginx page

### Limitations
+ There is no high availability or auto scaling.
+ Public IPs direct to the EC2 instances had to be exposed to allow Ansible from a desktop to execute.
+ Could have auto created the key pair for ssh to work. But decided that was not a priority, since its a once off task
+ Terraform state files are stored directly on the local file system