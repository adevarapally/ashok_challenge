output ec2_publicip {
    value = aws_instance.webserver.public_ip
}
