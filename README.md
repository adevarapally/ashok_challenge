SED Challenge:

Infrastructure:

For the challenge I assumed the all AWS VPC networking resources are created and have to deploy a EC2 instance and configure it to serve a statci website. I used Terraform and Ansible to provision environment and configure the server to sync any changes to the website.

I followed below steps to do:

    1) Created Keypair for login to EC2 instance

    2) Created Security Group to allow SSH,HTTP and HTTPS connections.

    3) Created EC2 instance with Public IP and enbaled Amazon linux extras to install Nginx.

    4) For unit testing running terraform fmt -check and terraform validate(Did not have much expeirence in writing integration tests for Terraform code but it can        be done terratest or kitchen-terraform)

    5) Used Ansible as configuration management tool to install and configure Nginx server to serve html conetent.

    6) For securing the website and server assumed any suspicious IP and port blocks to be done at NACL level. I created Security Group to allow SSH from my personal IP address, and allow HTTP connection on port 80 and 443.

    7) Created and updated Nginx to include site configuration to redirect http requests to HTTPS, SSL hardening confguration, and update iptables to allow only SSH, 80 and 443 ports, logs any packet drops and limit requests per minute on port 80 and 443.

    8) For additional security we can install WAF configuration on server or domain specific to block threats.

    9) Created a self signed certificate to use along with domain ashokchallenge.com (But having issue with legitimacy of the cert could not able to resolve it in the two hour window)

    10) Created test script to run through ansible after configuration to check HTTP redirection and content check on domain ashokchallenge.com

Coding:

For this challenege I choose Python as programming language and placed the code in creditcardvalidator folder.


