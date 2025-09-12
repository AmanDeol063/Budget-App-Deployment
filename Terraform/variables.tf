variable "aws_region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "budget-app-eks"
}

variable "db_username" {
  default = "budgetuser"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}
