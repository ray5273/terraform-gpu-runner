# Terraform GitHub Runner (GPU) - us-east-1

이 프로젝트는 GPU 기반 GitHub Actions Self-hosted Runner를 AWS `us-east-1` 리전에 배포하는 Terraform 코드입니다.

## 실행 방법

```bash
terraform init
terraform apply
```

## 주요 기능

- GPU 인스턴스 (`g4dn.xlarge`)
- Ephemeral runner (작업 시 생성 → 완료 시 자동 종료)
- 오토스케일링 (0 ~ 1)

## 사전 준비

1. GitHub Personal Access Token (repo 권한 포함)
2. AWS GPU 인스턴스 사용 승인 (EC2 Limits 확인)