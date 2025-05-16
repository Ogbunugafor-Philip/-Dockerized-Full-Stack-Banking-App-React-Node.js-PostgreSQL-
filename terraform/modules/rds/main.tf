resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "docker-db-subnet-group"
  subnet_ids = var.private_db_subnet_ids

  tags = {
    Name = "docker-db-subnet-group"
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = "docker-banking-db"
  engine                 = "postgres"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  db_name                = var.db_name
  username               = var.db_username
  password               = var.db_password

  # Commented out to fix DBParameterGroupNotFound error
  # parameter_group_name = "default.postgres15"

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]
  skip_final_snapshot    = true
  publicly_accessible    = false

  tags = {
    Name = "docker-banking-db"
  }
}
