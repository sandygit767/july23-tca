variable "vpc_cidr" {
  default     = "10.20.0.0/16"
  type        = string
  description = "Chose CIDR block for VPC"
}
variable "subnet_cidrs" {
  default     = ["10.20.0.0/24","10.20.1.0/24","10.20.2.0/24"]
  type        = list(string)
  description = "Chose CIDR block for Subnet"
}
variable "region" {
  default = "us-east-1"
  type    = string
}