# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A SINGLE EC2 INSTANCE
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_instance" "prod-web" {
  # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type in us-east-2
  ami                    = "ami-0522ab6e1ddcc7055"
  instance_type          = "t2.micro"
  key_name               = "devops"
  subnet_id              = [aws_subnet.prod-subnet-pub.id]
  vpc_security_group_ids = [aws_security_group.WEB_OUTSIDE_HTTP.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p "${var.server_port}" &
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
