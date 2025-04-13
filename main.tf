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

module "github_runner" {
  source  = "github-aws-runners/github-runner/aws"
  version = "~> 4.0"

  aws_region               = var.aws_region
  github_token             = var.github_token
  enable_ephemeral_runners = true

  runners = {
    gpu_pool = {
      instance_type     = "g6e.xlarge"
      os                = "linux"
      architecture      = "x64"
      minimum_count     = 0
      maximum_count     = 1
      ami_filter = {
        name        = "ubuntu/images/hvm-ssd/ubuntu-22.04-amd64-server-*"
        owners      = ["099720109477"]
        most_recent = true
      }
      root_volume_size = 100
    }
  }

  tags = {
    Project     = "github-runner-gpu"
    Environment = "dev"
  }
}