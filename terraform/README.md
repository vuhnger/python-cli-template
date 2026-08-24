# terraform

Holder GitHub-oppsettet i kode: squash-only, ingen push rett til main, grønn CI før
merge, og ingen force push eller sletting av main.

```
cp terraform.tfvars.example terraform.tfvars
export GITHUB_TOKEN=$(gh auth token --hostname github.com)
terraform -chdir=terraform init
terraform -chdir=terraform apply
```

Finnes repoet allerede, legg til en `import`-blokk i `main.tf` ved første kjøring:

```hcl
import {
  to = module.repository.github_repository.this
  id = "navnet-på-repoet"
}
```

`required_status_checks` må matche navnet på jobben i `.github/workflows/ci.yml`.
Endrer du jobbnavnet uten å endre dette, blir main låst.
