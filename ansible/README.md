Using Ansible as configuration management tool to install and configure Nginx as webserver and update website staic content.
Ansible directory structure:
paste image

1) inventory.yaml has the hosts and variables.
2) nginx.yaml has code to installation and configyration steps.
3) website.yaml has code to configure website content.
4) iptables.yaml has code to configure linux firewall rules.
5) selfsignedcert.yaml has code to create self signed certifcates.
6) site directory has static html file for website content.
7) template directory has nginx config file for the website.
