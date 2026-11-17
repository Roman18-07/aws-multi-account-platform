# Validation results

Date: 2026-11-17.

## Toolchain

- OpenTofu 1.11.5, downloaded from the official release with SHA256 verification.
- Existing AWS provider locks: `aws-base` 5.70.0,
  `aws-base-accounts-init` 5.98.0, `aws-github-roles` 6.35.1.
- Python 3; validation runner uses only the standard library.
- actionlint 1.7.7; Gitleaks 8.24.2; yamllint 1.35.1 for local CI checks.

The source lockfiles identify providers through `registry.opentofu.org`. They were
not rewritten for Terraform's provider registry. This is why the documented local
and CI validation uses OpenTofu despite the source's Terraform HCL/file naming.
No provider version was upgraded.

## Executed checks

| Check | Result |
| --- | --- |
| Formatting of all destination Terraform roots and modules | PASS |
| HCL syntax/formatting of example tfvars and backend settings, loaded as temporary tfvars | PASS |
| `tofu init -backend=false -input=false -lockfile=readonly`, aws-base | PASS |
| `tofu validate -no-color`, aws-base | PASS |
| Same isolated init/validate, aws-base-accounts-init | PASS |
| Same isolated init/validate, aws-github-roles and seven local module calls | PASS |
| All 252 original resource/data/module declarations retained | PASS |
| All three original provider lockfiles byte-identical | PASS |
| Known source AWS account IDs, corporate name and domain strings absent from public files | PASS |
| Gitleaks scan of standalone current files | PASS; no leaks detected |
| Gitleaks scan of existing destination history | PASS; one pre-existing README-only commit scanned |
| actionlint on the new GitHub Actions workflow | PASS; optional shellcheck integration disabled locally |
| CI YAML syntax/duplicate keys, inline Bash syntax, Python script syntax | PASS |
| Source file checksum comparison | PASS; source content unchanged |

All three roots were validated in disposable temporary directories. Backend
initialization was disabled, live AWS configuration/credentials were excluded,
and provider downloads/caches stayed outside the project. No state, plan,
`.terraform` directory or provider binary is included in the standalone project.
The existing destination Git metadata was preserved.

## Reproduce locally

Install OpenTofu 1.11.5 on PATH, then from the repository root:

```sh
python3 scripts/validate.py
```

Select a single root if needed:

```sh
python3 scripts/validate.py aws-base
python3 scripts/validate.py aws-base-accounts-init
python3 scripts/validate.py aws-github-roles
```

The script does not edit source Terraform, initialize live backends or run a plan
or apply. It validates configuration/schema compatibility rather than a concrete
AWS deployment. Example input syntax is checked; example account IDs, profiles,
emails, groups and organization root are deliberately fictitious.

## CI coverage

The workflow validates each root independently on ARM runners and scans both
current files and full fetched Git history for secrets. It runs on pull requests
to main, pushes to main and manual dispatch. It requires no AWS secrets, private
workflows, deployment role or backend credentials. GitHub-hosted execution has
not been triggered during preparation; local checks were run on Linux AMD64.

## Not executed or established

- No Terraform/OpenTofu plan, apply, destroy, account creation/closure, state import,
  backend migration, AWS API deployment or Git push.
- No live verification of organization/root placement, IAM Identity Center groups,
  account assignments, role-session trust, OIDC claims, IAM effective permissions,
  security-service activation, budgets/email delivery or S3/DynamoDB access.
- No assertion that broad original IAM policies satisfy least-privilege or that
  Organizations trusted access provides absent SCPs/security-service deployments.
- Secret scanning and targeted identifier checks cannot prove the absence of all
  confidential information. Publication-rights review remains unresolved as
  documented in [PROVENANCE.md](PROVENANCE.md).
