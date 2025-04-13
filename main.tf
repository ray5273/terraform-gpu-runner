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
    id              = var.github_app_id
    installation_id = var.github_app_installation_id
    key_base64       = var.github_app_key_base64
    webhook_secret   = var.github_app_webhook_secret
  }
  webhook_lambda_zip                = "lambdas-download/webhook.zip"
  runner_binaries_syncer_lambda_zip = "lambdas-download/runner-binaries-syncer.zip"
  runners_lambda_zip                = "lambdas-download/runners.zip"

  runner_os               = "linux"
  runner_architecture     = "x64"
  enable_ephemeral_runners = true
  enable_ssm_on_runners    = true

    # runners 대신 ephemeral_runners 사용
 ephemeral_runners = {
   gpu_pool = {
     instance_type        = "g6e.xlarge"
     ami_filter           = { name = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] }
     ami_owners           = ["099720109477"] # Canonical
     subnet_ids           = module.vpc.public_subnets
     min_running_instances = 0
     max_running_instances = 1
     runner_extra_labels  = ["gpu"]
   }
 }

 # 스케일링 관련 최적화 설정
 scale_down_schedule_expression = "cron(*/5 * * * ? *)"
 idle_config = [{
   cron      = "* * * * *"
   timeZone  = "UTC"
   idleCount = 0
 }]

     # scaling_down_delay_seconds 제거
}