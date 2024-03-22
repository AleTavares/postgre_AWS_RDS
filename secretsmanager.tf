resource "aws_secretsmanager_secret_version" "postgres_db" {
  secret_id     = aws_secretsmanager_secret.postgres_db.id
  secret_string = <<EOT
{
  "master_username": "${var.db_username}",
  "master_password": "${random_password.db_master_password.result}",
  "read_only_username": "${var.db_username}_db",
  "read_only_password": "${random_password.db_read_only_password.result}",
}
EOT
}
