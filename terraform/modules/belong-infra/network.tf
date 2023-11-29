resource "aws_vpc" "belong_vpc_prod" {
  cidr_block = var.vpc_cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "belong_public_subnet" {
  vpc_id     = aws_vpc.belong_vpc_prod.id
  cidr_block = var.public_subnet
  availability_zone = "ap-southeast-2a"
}

resource "aws_subnet" "belong_private_subnet_a" {
  vpc_id     = aws_vpc.belong_vpc_prod.id
  cidr_block = var.private_subnet_a
  availability_zone = "ap-southeast-2a"
}

resource "aws_subnet" "belong_private_subnet_b" {
  vpc_id     = aws_vpc.belong_vpc_prod.id
  cidr_block = var.private_subnet_b
  availability_zone = "ap-southeast-2b"
}

resource "aws_subnet" "belong_private_subnet_c" {
  vpc_id     = aws_vpc.belong_vpc_prod.id
  cidr_block = var.private_subnet_c
  availability_zone = "ap-southeast-2c"
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.belong_vpc_prod.id
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.belong_vpc_prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.belong_public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_security_group" "sg_http_access" {
  description = "Allow http inbound traffic"
  vpc_id = aws_vpc.belong_vpc_prod.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.belong_private_subnet_a.cidr_block ,
      aws_subnet.belong_private_subnet_b.cidr_block,
      aws_subnet.belong_private_subnet_c.cidr_block
      ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sg_https_access" {
  description = "Allow https inbound traffic"
  vpc_id = aws_vpc.belong_vpc_prod.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.belong_private_subnet_a.cidr_block,
      aws_subnet.belong_private_subnet_b.cidr_block,
      aws_subnet.belong_private_subnet_c.cidr_block
      ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "sg_ssh_access" {
  description = "Allow ssh inbound traffic"
  vpc_id = aws_vpc.belong_vpc_prod.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [
      aws_subnet.belong_private_subnet_a.cidr_block,
      aws_subnet.belong_private_subnet_b.cidr_block,
      aws_subnet.belong_private_subnet_c.cidr_block
      ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}