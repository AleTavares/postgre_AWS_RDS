resource "aws_db_instance" "erp" {
  allocated_storage    = var.allocated_storage
  storage_type         = var.storage_type
  instance_class       = var.instance_class
  identifier           = var.identifier
  engine               = var.engine
  engine_version       = var.engine_version
  parameter_group_name = var.parameter_group_name

  db_name  = var.db_name
  username = var.db_username
  password = random_password.db_admin_password.result

  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = true # Only for testing!
  skip_final_snapshot    = true
}
