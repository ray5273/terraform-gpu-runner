terraform {
  backend "remote" {
    organization = "ray5273"

    workspaces {
      name = "github-runner"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.0"

  name = "github-runner-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway     = false
  single_nat_gateway     = false
  enable_dns_support     = true
  enable_dns_hostnames   = true

  tags = {
    Name = "github-runner-vpc"
  }
}

module "github_runner" {
  source  = "github-aws-runners/github-runner/aws"
  version = "~> 5.0"

  aws_region = var.aws_region
  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets

  github_app = {
    id              = var.TF_VAR_github_app_id
    installation_id = var.TF_VAR_github_app_installation_id
    private_key     = var.TF_VAR_github_app_private_key
  }

  runner_os               = "linux"
  runner_architecture     = "x64"
  enable_ephemeral_runners = true
  enable_ssm_on_runners    = true
}