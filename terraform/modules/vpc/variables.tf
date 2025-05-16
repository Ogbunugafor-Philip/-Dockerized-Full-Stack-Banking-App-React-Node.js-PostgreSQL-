variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  default     = "Docker_Project"
}

variable "igw_name" {
  default = "Docker_Project-igw"
}

variable "nat_gateway_name" {
  default = "Docker_Project-nat"
}

variable "public_rt_name" {
  default = "Docker_Project-public-rt"
}

variable "private_rt_name" {
  default = "Docker_Project-private-rt"
}

variable "public_subnet_az1" {
  default = "10.0.1.0/24"
}

variable "public_subnet_az2" {
  default = "10.0.2.0/24"
}

variable "private_web_subnet_az1" {
  default = "10.0.3.0/24"
}

variable "private_web_subnet_az2" {
  default = "10.0.4.0/24"
}

variable "private_db_subnet_az1" {
  default = "10.0.5.0/24"
}

variable "private_db_subnet_az2" {
  default = "10.0.6.0/24"
}

variable "az1" {
  default = "us-east-1a"
}

variable "az2" {
  default = "us-east-1b"
}
