provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "todo_app" {
  ami           = "ami-0ca9fb66e076a6e32" # Use a valid Amazon Linux 2 AMI
  instance_type = "t2.micro"

  tags = {
    Name = "todo-app-instance"
  }
}

resource "aws_db_instance" "todo_db" {
  engine            = "mysql"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  db_name           = "tododb"
  username          = var.db_username
  password          = var.db_password
  publicly_accessible = false

  tags = {
    Name = "todo-app-database"
  }
}
