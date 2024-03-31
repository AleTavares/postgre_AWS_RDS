# Instancia AWS RDS Postgre com Terraform 
A idéia deste projeto é criar uma Instancia de RDS (Relational Database Service) na AWS para simular a base de dados de um ERP.

Está ideia sugiu depois de muitas pessoas me procurarem perguntando como elas fazem para estudar ETL e simular a estração de dados.

Vamos subir uma Instancia de AWS RDS via terraform com um usuario restrito e usando o Secretmanager para simular uma instancia de banco de dados real.

# Pré requisitos
- Uma conta AWS com permissões apropriadas para criar recursos como instâncias Ec2, instâncias RDS e acesso Terraform.
- Terraform instalado em sua máquina local.
- Conhecimento básico de PostgreSQL e AWS RDS.

# Utilizando o Repo
**Crie um Arquivo chamado terraform.tfvars e inclua os códigos abaixo colocando valores para as variaveis**
```terraform
# Variaveis Utilizadas no Secret Manager
secret_name = "RDAccess" 
db_username = "dbPostgres"

# Variaveis Utilizadas na Instancia do RDS
allocated_storage    = 20
storage_type         = "gp2"
instance_class       = "db.t3.micro"
identifier           = "db-erp"
engine               = "postgres"
engine_version       = "14.7"
parameter_group_name = "default.postgres14"
db_name              = "northwind"
rds-security-group   = "postgres-erp"
```
```bash
terraform ini
```
Para inicializar o ambiente do terraform

```bash
terraform plan -out plan.out
```
Para Gerar o plano de execução

```bash
terraform apply plan.out
```
Para aplicar o plano de execução na AWS

> [!NOTE]
> Crie as chaves de acesso da AWS e coloque nas variaveis de ambiente:
> - AWS_ACCESS_KEY_ID 
> - AWS_SECRET_ACCESS_KEY


> [!NOTE]
> Para simular uma base de dados de origem será necessário importar o arquivo northwind.sql que está na pasta scripts para a base de dados criada.
> Pensei em automatizar esta tarefa, mas cheguei a conclusão de que vou deixar esta etapa para vocês.
> Aceitarei os PR de quem resolver o desafio.