resource "random_password" "db_master_password" {
  length  = 16
  special = false
}

resource "random_password" "db_read_only_password" {
  length  = 16
  special = false
}

resource "aws_secretsmanager_secret" "postgres_db" {
  name = var.secret_name
  recovery_window_in_days = 0
}

resource "aws_db_instance" "postgres_rds" {
  allocated_storage    = var.allocated_storage
  identifier           = var.identifier
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = random_password.db_read_only_password.result
  parameter_group_name = var.parameter_group_name
  db_subnet_group_name = aws_db_subnet_group.db-subnet.name
  skip_final_snapshot = true
}

resource "aws_db_subnet_group" "db-subnet" {
  name = var.db_subnet_group_name
  subnet_ids  = [
   aws_subnet.db_subnet[0].id,
   aws_subnet.db_subnet[1].id,
   aws_subnet.db_subnet[2].id
  ]
}

data "http" "my_ip" {
  url = "http://checkip.amazonaws.com/"
}

resource "aws_iam_role" "bastion_role" {
  name               = "bastion-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_security_group" "sg-bastion-host" {
  name        = "sg_for_bastion-host"
  description = "security group for bastion host"
  vpc_id      = aws_vpc.default.id

ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.my_ip.body)}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name          = "sg_for_bastion"

  }
}
resource "aws_iam_instance_profile" "iam_profile" {
  name = "bastion-profile"
  role = aws_iam_role.bastion_role.name
}

resource "aws_instance" "bastion_host" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg-bastion-host.id]
  key_name               = aws_key_pair.bastion-key.key_name
  iam_instance_profile    = aws_iam_instance_profile.iam_profile.id
  subnet_id               = aws_subnet.public_subnet[0].id 
  tags = {
    Name = "bastion-host"
  }
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
}

resource "aws_key_pair" "bastion-key" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh

  provisioner "local-exec" { # Create a "myKey.pem" to your computer!!
    command = "echo '${tls_private_key.this.private_key_pem}' > ~/${var.key_name}.pem"
  }
}