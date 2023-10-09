resource "aws_vpc" "main" {
  cidr_block       = "10.20.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name       = "jhc-tca1"
    Location   = "Bangluru"
    CostCentre = "JHC1234"
  }
}
# Create subnet in the above VPC
resource "aws_subnet" "main" {
  count = length(local.az_names)
  vpc_id            = aws_vpc.main.id
  availability_zone = local.az_names[count.index]
  cidr_block        = cidrsubnet (var.vpc_cidr,8,count.index)
  tags = {

    Name = "MySubnet-${count.index + 1}"
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