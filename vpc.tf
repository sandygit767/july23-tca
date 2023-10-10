resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name       = "jhc-tca1-${local.ws}"
    Location   = "Bangluru"
    CostCentre = "JHC1234"
  }
}
# Create subnet in the above VPC
resource "aws_subnet" "main" {
  count             = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  availability_zone = local.az_names[count.index]
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index)
  tags = {

    Name = "MySubnet-${count.index + 1}-${local.ws}"
  }
}
# VPC that is manually created

/*resource "aws_vpc" "cloud-app" {
  cidr_block = "10.0.0.0/20"
  instance_tenancy = "default"
  tags = {
    Name = "jh-cloud-app"
    Department = "IT"
    Location = "Banglore"
  }
}*/

#Create this only in non dev
/*resource "aws_vpc" "main2" {
  count            = local.ws == "dev" ? 0 : 1
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name       = "jhc-tca1-${local.ws}"
    Location   = "Bangluru"
    CostCentre = "JHC1234"
  }
}*/

# Create internet gateway

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# Create route rable for public subnetrs

resource "aws_route_table" "public"{
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "example"
  }
}
# associate public route table with subnets

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.main.*.id[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web" {
  name        = "web-security-group"
  description = "Allow traffic for web applications"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = "TLS from VPC"
      from_port   = ingress.value["port"]
      to_port     = ingress.value["port"]
      protocol    = "tcp"
      cidr_blocks = ingress.value["cidrs"]
    }
  }
  /*ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "TLS from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["49.207.196.15/32"]
  }*/

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
