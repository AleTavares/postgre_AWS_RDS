resource "aws_secretsmanager_secret" "postgres_db" {
  name                    = var.secret_name
  recovery_window_in_days = 0
}

resource "random_password" "db_admin_password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret_version" "postgres_db_secret" {
  secret_id     = aws_secretsmanager_secret.postgres_db.id
  secret_string = <<EOT
{
  "admin_username": "${var.db_username}",
  "admin_password": "${random_password.db_admin_password.result}"
}
EOT
}
