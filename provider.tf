terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "6.48.0"
    }
  }
  backend "s3" {
    bucket       = "manoharmotam-remote-state-test"
    key          = "docker.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}