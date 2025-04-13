# Terraform GitHub Runner with VPC

## 구성 요소

- VPC + Public Subnet 2개 자동 생성 (us-east-1a/b)
- GitHub App 기반 Ephemeral Runner 배포
- Terraform Cloud Backend 사용

## 설정 방법

1. GitHub App 생성 → App ID, Installation ID, Private Key 획득
2. AWS IAM Access Key 발급 → Terraform Cloud에 환경변수로 등록
3. `terraform.tfvars.example` 참고해서 입력
4. Terraform Cloud 연결 후 실행

## 필요 환경 변수 (Terraform Cloud)

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `GITHUB_APP_ID`
- `GITHUB_APP_INSTALLATION_ID`
- `GITHUB_APP_PRIVATE_KEY`

## 실행 방법

```bash
terraform init
terraform apply
```