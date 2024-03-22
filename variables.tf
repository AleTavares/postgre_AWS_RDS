#-------------------------------------------------------------
#--- Variaveis de Rede ---------------------------------------
#-------------------------------------------------------------
variable "vpc_cidr_block" {
  description = "CIDR block da VPC"
  default     = "10.50.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.50.0.0/24", "10.50.1.0/24", "10.50.2.0/24"]
}

variable "db_subnets_cidr_blocks" {
  type    = list(string)
  default = ["10.50.16.0/24", "10.50.32.0/24", "10.50.64.0/24"]
}


variable "vpc_name" {
  description = "Name of the VPC"
  default     = "open-source_projects"
}

variable "subnet_count" {
  type = number
  default = 1
}

#-------------------------------------------------------------
#--- Variaveis de Instancia Postgre --------------------------
#-------------------------------------------------------------
variable "identifier" {
  default = "postgres-rds-db"
}
variable "allocated_storage" {
  default = 20
}
variable "storage_type" {
 default = "gp2" 
}
variable "engine" {
  default = "postgres"
}
variable "engine_version" {
  default = 14.7
}
variable "instance_class" {
  default = "db.t3.micro"
}
variable "db_name" {
  default = "postgres_db"
}
variable "parameter_group_name" {
  default = "default.postgres14"
}


variable "azs" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "count_index" {
  type = number
  default = 3
}

variable "db_subnet_group_name" {
  type = string
  default = "db-subnet-group"
}

variable "secret_name" {
  type = string
  default = "Open-source"
}

variable "key_name" {
  type = string
  default = "postgres-key"
}

variable "ami_id" {
  type = string
  default = "ami-06ca3ca175f37dd66"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "db_username" {
  type = string
  default = "read_only_user"
}

