#-----------------------------------------------------------------------------------
#--- Variaveis AWS Secretsmanager --------------------------------------------------
#-----------------------------------------------------------------------------------
variable "secret_name" {
  description = "Nome Para o AWS Secretsmanager da Base de Dados."
  type        = string
}

variable "db_username" {
  description = "Usuario Admin da Base de Dados."
  type        = string
  sensitive   = true
}


#-----------------------------------------------------------------------------------
#--- Variaveis AWS RDS -------------------------------------------------------------
#-----------------------------------------------------------------------------------
variable "allocated_storage" {
  description = "Tamanho do storage do AWS RDS."
  type        = string
}

variable "storage_type" {
  description = "Tipo de Storage da Storage do AWS RDS."
  type        = string
}

variable "instance_class" {
  description = "Tipo de instancia do AWS RDS."
  type        = string
}

variable "identifier" {
  description = "Nome da instancia do AWS RDS."
  type        = string
}

variable "engine" {
  description = "Tipo do Engine de Banco de Dados da instancia do AWS RDS."
  type        = string
}

variable "engine_version" {
  description = "Versão do Engine de Banco de Dados da instancia do AWS RDS."
  type        = string
}

variable "parameter_group_name" {
  description = "Group Name da instancia do AWS RDS."
  type        = string
}

variable "db_name" {
  description = "Nome da Base de Dados da instancia do AWS RDS."
  type        = string
}

variable "rds-security-group" {
  description = "Security group que será utilizado na instancia do AWS RDS."
  type        = string
}
