# python-cli-template

Startpunkt for et Python-CLI: src-layout, uv, ruff, mypy, ty, pytest, CI, release til
PyPI med trusted publishing, og GitHub-reglene i Terraform.

## Ta det i bruk

1. `gh repo create mitt-repo --template vuhnger/python-cli-template --public --clone`
2. Bytt `appname` til pakkenavnet ditt i `pyproject.toml`, `src/`, `tests/` og
   `.github/workflows/ci.yml`.
3. `uv venv && uv pip install -e ".[dev]"`
4. `cp terraform/terraform.tfvars.example terraform/terraform.tfvars` og fyll inn navn.
5. `export GITHUB_TOKEN=$(gh auth token --hostname github.com)`
6. `terraform -chdir=terraform init && terraform -chdir=terraform apply`
7. Tillat at Actions kan opprette PR-er, ellers feiler release-please:
   `gh api -X PUT repos/vuhnger/mitt-repo/actions/permissions/workflow -F can_approve_pull_request_reviews=true -F default_workflow_permissions=write`

Etter punkt 6 er main beskyttet: squash-only, ingen push rett til main, grønn CI før
merge, og ingen force push eller sletting.

## Nyttige kommandoer

```
uv run pytest -q                          kjør testene
uv run ruff check src tests               lint
uv run ruff format src tests              formater
uv run mypy                               typesjekk
uv run ty check src/appname               rask typesjekk
terraform -chdir=terraform plan           se hva som endres i repo-oppsettet
terraform -chdir=terraform apply          ta i bruk repo-reglene
```

## Release

Release-please samler Conventional Commits fra main i en release-PR. Merger du den,
settes taggen og GitHub-releasen, og `publish.yml` bygger og laster opp til PyPI.
Registrer repoet som trusted publisher på pypi.org først, ellers finnes det ingen
nøkkel og publiseringen feiler.

Repo-reglene kommer fra `vuhnger/terraform-github-repo`, så en regelendring gjøres ett
sted og hentes inn ved å bumpe `ref` i `terraform/main.tf`.
