variable "private_db_subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

variable "rds_sg_id" {
  description = "Security group ID for RDS"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
  default     = "bankingdb"
}

variable "db_username" {
  description = "Master DB username"
  type        = string
  default     = "Docker_project_db"
}

variable "db_password" {
  description = "Master DB password"
  type        = string
  sensitive   = true
}
