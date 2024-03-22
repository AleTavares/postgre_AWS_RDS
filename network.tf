data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "vpcPostgreRDS" {
  cidr_block = var.vpc_cidr_block
  tags = {
    name = "${var.vpc_name}"
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = length(var.public_subnet_cidr_blocks)
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet_cidr_blocks[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "db_subnet" {
  count             = length(var.db_subnets_cidr_blocks)
  vpc_id            = aws_vpc.default.id
  cidr_block        = var.db_subnets_cidr_blocks[count.index]
  availability_zone = data.aws_availability_zones.available.names[count.index]
  tags = {
    Name = "Database Subnets"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = "postgres IGW"
  }
}

# Create Web layber route table
resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "WebRT"
  }
}

resource "aws_security_group" "allow_all" {
  name   = "sg_for_rds"
  vpc_id = aws_vpc.default.id
  description = "RDS instance security group"
  ingress {
    description = "All Traffic"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [var.public_subnet_cidr_blocks[0],
    var.public_subnet_cidr_blocks[1],
    var.public_subnet_cidr_blocks[2],
    var.db_subnets_cidr_blocks[0],
    var.db_subnets_cidr_blocks[1],
    var.db_subnets_cidr_blocks[2]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "allow_all"
  }
}
