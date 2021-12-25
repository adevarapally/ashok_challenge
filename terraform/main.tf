# Creating dependent resources 
# SSH key pair to login to EC2 instance
resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "local_file" "private_key" {
  filename          = "${var.name}-key.pem"
  sensitive_content = tls_private_key.key.private_key_pem
  file_permission   = "0400"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.name}-key"
  public_key = tls_private_key.key.public_key_openssh
}

# Security Group to allow access to EC2 instance
resource "aws_security_group" "webserver-sg" {
  name        = "${var.name}-allow_ssh_http"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.vpcid

  ingress {
    description = "SSH from the internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["98.195.103.167/32"]
  }

  ingress {
    description = "HTTP from the internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from the internet"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.name}-allow_ssh"
  }
}

# AMI filter to pickup latest AMI availble in respective region
data "aws_ami" "amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

# Creating EC2 instance
resource "aws_instance" "webserver" {
    depends_on = [
      aws_security_group.webserver-sg,
    ]
  ami = data.aws_ami.amazon-linux-2.id
  associate_public_ip_address = true
  instance_type = var.instance_type
  key_name = aws_key_pair.key_pair.key_name
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.webserver-sg.id]
  user_data = <<EOF
  #!/bin/bash
  echo "changing hostname"
  hostname webserver
  echo "webserver" > /etc/hostname
  sudo amazon-linux-extras enable nginx1
  yum clean metadata
  EOF

  tags = {
      "Name" = "${var.name}-public"
  }

}

# Copying EC2 instance Public and Private IPs to local file to use as variable in Ansible
resource "local_file" "tf_ansible_vars_file" {
  content = <<-DOC
    public_ip = ${aws_instance.webserver.public_ip}
    private_ip = ${aws_instance.webserver.private_ip}
  DOC
  filename = "./tf_ansible_vars_file.yaml"
}