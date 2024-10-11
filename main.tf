# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A SINGLE EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "prod-web" {
  # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type in us-east-2
  ami                    = "ami-0522ab6e1ddcc7055"
  instance_type          = "t3.micro"
  key_name               = "devops"
  subnet_id              = "subnet-01ef5f960948ff6f6"
 security_groups        = ["sg-0c61860f1f8e02da3"]
 # subnet_id              = [aws_subnet.prod-subnet-pub.id]
 # vpc_security_group_ids = [aws_security_group.WEB_OUTSIDE_HTTP.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
                sudo apt-get update -y
                sudo apt-get install apache2 -y
                sudo systemctl start apache2
                echo "WEB $(hostname -f)" > /var/www/html/index.html &
                EOF

  tags = {
    Name = "Prod-Webserver"
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE SECURITY GROUP THAT'S APPLIED TO THE EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

#resource "aws_security_group" "instance" {
 # name = "terraform-example-instance"

  # Inbound HTTP from anywhere
 # ingress {
  #  from_port   = var.server_port
   # to_port     = var.server_port
   # protocol    = "tcp"
   # cidr_blocks = ["0.0.0.0/0"]
  #}
#}
