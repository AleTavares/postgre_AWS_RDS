# data "local_file" "sql_script" {
#   filename = "${path.module}/script/northwind.sql"
# }

# resource "null_resource" "db_setup" {
#   depends_on = [
#     aws_db_instance.erp,
#     aws_security_group.rds,
#   ]

#   provisioner "local-exec" {
#     command = "export PGPASSWORD=${random_password.db_admin_password.result} | psql -h ${aws_db_instance.erp.address} -p 5432 -U ${var.db_username} -d ${var.db_name} -f script/northwind.sql"
#   }
# }

