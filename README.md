# terraform-checkov-ci
development of a security gate that blocks a misconfigured AWS S3 change before merging

## 1. Problem / security goal
Iac changes can introduce cloud misconfigurations.
This repo runs a security gate on each pull request and push to `main`.
 
## 2. Architecture
Terraform files -> GitHub PR -> Actions -> fmt + validate + Checkov -> pass/fail.
See [architecture notes](docs/architecture.md).
 
## 3. Repository map
 
## 4. Prerequisites
Installed: Git, Terraform (latest), Python (latest) and Checkov.
Baseline scan doesn't require AWS spending.
 
## 5. Run the checks locally
```
terraform -chdir=infra fmt
terraform -chdir=infra init -backend=false
terraform -chdir=infra validate
python -m pip install 'checkov>=3.2,<4'
checkov -d infra --framework terraform --check CKV_AWS_53,CKV_AWS_54,CKV_AWS_55,CKV_AWS_56 --compact
```
 
## 6. GitHub Actions & passing results
The workflow runs on `pull_request` and pushes to `main`.
 
## 7. Controlled failure and remediation
In a temporary branch, `block_public_policy = false`.
Open a PR; Checkov should fail CKV_AWS_54.
Revert to `true` and rerun.
**Never apply the intentionally insecure branch.**
 
## 8. Security controls
- CKV_AWS_53: `block_public_acls = true`
- CKV_AWS_54: `block_public_policy = true`
- CKV_AWS_55: `ignore_public_acls = true`
- CKV_AWS_56: `restrict_public_buckets = true`
 
## 9. deployment and cleanup
```
terraform -chdir=infra plan
terraform -chdir=infra apply
terraform -chdir=infra destroy
```
`terraform apply` is OPTIONAL; the core project runs without AWS.
Never commit `.tfstate`, `.tfvars` or credentials. Confirm any bucket
is empty before destroying it; versioned objects may need explicit cleanup.

 
## 10. Limitations & next steps
 
## 11. What I learned
