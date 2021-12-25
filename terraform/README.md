I used terraform to provision AWS resources ec2, and security group.

terraform folder structure:
README.md
variables.tf
outputs.tf
main.tf


1) main.tf file has code to create ec2 instance and security group.
2) variables.tf file has all vairables needed to create ec2 instance and security group.
3) outputs.tf has outpust needed for Ansible configuration
