provider "aws" {
	region = "eu-west-1"
}


resource "aws_vpc" "HussainVPC" {
  cidr_block       = "102.0.0.0/16"
  tags = {
    Name = "Eng57.Hussain.VPC.TF"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.HussainVPC.id

  tags = {
    Name = "Eng57.Hussain.IG.TF"
  }
}
resource "aws_subnet" "subnet-pub" {
  vpc_id     = aws_vpc.HussainVPC.id
  cidr_block = "102.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "Eng57.Hussain.PubSub.TF"
  }
}

resource "aws_security_group" "sg-app" {
  name        = "webApp-SG"
  description = "Allow http and https traffic "
  vpc_id      = aws_vpc.HussainVPC.id

  ingress {
    description = "https from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "http from VPC"
    from_port   = 80
    to_port     = 80
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
    Name = "Eng57.Hussain.SG.TF"
  }
}

resource "aws_network_acl" "public-nacl" {
  vpc_id = aws_vpc.HussainVPC.id

  egress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 80
    to_port    = 80
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 120
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  tags = {
    Name = "Eng57.Hussain.NACL.pub.TF"
  }
}

resource "aws_route_table" "route-pub" {
  vpc_id = aws_vpc.HussainVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Eng57.Hussain.Pub.Route.TF"
  }
}

resource "aws_instance" "instance-web"{
  ami       = "ami-0e4a6a9db6fb20e1f"
  instance_type   = "t2.micro"
  subnet_id = aws_subnet.subnet-pub.id
  vpc_security_group_ids = [aws_security_group.sg-app.id]
  associate_public_ip_address = true

  tags = {
    Name = "Eng57.hussain.tf.app"
  }
} 

# data "template_file" "initapp" {
#   template = file("./scripts/app/init.sh.tpl")
# }

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet-pub.id
  route_table_id = aws_route_table.route-pub.id
}