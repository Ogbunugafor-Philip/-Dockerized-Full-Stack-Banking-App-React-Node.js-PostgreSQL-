variable "db_password" {
  description = "Password for the RDS PostgreSQL database"
  type        = string
  sensitive   = true
}

variable "db_username" {
  description = "Master DB Username"
  type        = string
}

