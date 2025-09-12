module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.5.2"

  identifier = "budget-app-db"
  engine     = "postgres"
  engine_version = "15.3"
  instance_class = "db.t3.micro"

  allocated_storage = 20
  username          = var.db_username
  password          = var.db_password
  db_subnet_group_name = module.vpc.database_subnet_group
  vpc_security_group_ids = [module.vpc.default_security_group_id]

  skip_final_snapshot = true
}
