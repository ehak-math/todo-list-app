variable "db_username" {
  default     = "admin"
  description = "Database username"
}

variable "db_password" {
  default     = "ProjectG2"
  description = "Database password"
  sensitive   = true
}
