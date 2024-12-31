provider "aws" {
  region = var.aws_region
}

# Security Group for the EC2 Instance
resource "aws_security_group" "web_sg" {
  name        = "web-server-sg"
  description = "Allow HTTP, HTTPS, and SSH access"
  vpc_id      = "default" # Replace with VPC ID if not using default VPC

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Security Group for the RDS Database
resource "aws_security_group" "db_sg" {
  name        = "db-server-sg"
  description = "Allow MySQL access"
  vpc_id      = "default" # Replace with VPC ID if not using default VPC

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Consider restricting to specific IPs for security
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "app_server" {
  ami           = "ami-01816d07b1128cd2d"
  instance_type = "t2.micro"
  key_name      = var.key_name

  tags = {
    Name = "TodoListAppServer"
  }

  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

# RDS Instance
resource "aws_db_instance" "todo_db" {
  engine             = "mysql"
  instance_class     = "db.t3.micro"
  db_name            = "todo_db"
  username           = "admin"
  password           = "todo123"
  allocated_storage  = 20
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  # Enable deletion protection for production use
  skip_final_snapshot = true
}
