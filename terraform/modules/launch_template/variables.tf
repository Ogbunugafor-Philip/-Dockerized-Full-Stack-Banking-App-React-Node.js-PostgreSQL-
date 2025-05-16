variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "SSH key pair name"
  type        = string
}

variable "ec2_sg_id" {
  description = "Security Group ID for EC2"
  type        = string
}

variable "aws_region" {
  description = "AWS region (for ECR login)"
  type        = string
}

variable "ecr_url" {
  description = "ECR registry URL (e.g., 123456789012.dkr.ecr.region.amazonaws.com)"
  type        = string
}

variable "backend_image" {
  description = "Docker image name (e.g., banking-backend)"
  type        = string
}
