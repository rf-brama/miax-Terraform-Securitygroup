terraform {
  backend "s3" {
    bucket  = "miax-state-files"
    key     = "Securitygroup/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
    dynamodb_table = "dynamodb-state-locking"    
  }
}