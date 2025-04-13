variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}

variable "github_app_installation_id" {
  description = "GitHub App Installation ID"
  type        = string
}
variable "github_app_key_base64" {
  description = "Base64 encoded GitHub App private key"
  type        = string
}
variable "github_app_webhook_secret" {
  description = "GitHub App Webhook Secret"
  type        = string
}