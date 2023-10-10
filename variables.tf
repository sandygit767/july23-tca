variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  type        = string
  description = "Chose CIDR block for VPC"
}
variable "subnet_cidrs" {
  default     = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"]
  type        = list(string)
  description = "Chose CIDR block for Subnet"
}
variable "region" {
  default = "us-east-1"
  type    = string
}
variable "ingress_rules" {
  type = map(object({
    port  = string
    cidrs = list(string)
  }))
  /*default = {
    "1" = {
      port  = 22
      cidrs = ["49.207.196.15/32"]

    },
    "2" = {
      port  = 443
      cidrs = ["0.0.0.0/0"]
    },
    "3" = {
      port  = 3389
      cidrs = ["0.0.0.0/0"]
    }
  }*/
}
variable "ami" {
  default = "ami-067d1e60475437da2"
}