# Provenance and publication review

## Existing implementation retained

The three root directories and `aws-github-roles/modules/attach_iam_policies` were
extracted from the existing `aws-management` Terraform implementation. All
Terraform files and each root's OpenTofu provider lockfile were retained. No
resource/data/module addresses, service policy catalogs or trust-policy statement
logic were intentionally replaced with new implementations.

The extraction retained 103 Terraform/lock files before adding standalone inputs,
provider-version declarations, validation, CI and documentation. These are copied
source-derived configurations, not a clean-room implementation or a new AWS
landing-zone architecture.

| Paths | Origin / treatment | Publication-rights status |
| --- | --- | --- |
| `aws-base/*.tf` except `versions.tf` | Original organization/account/SSO/cost code; account email domain and repository tag sanitized | Unconfirmed; source contained no license grant |
| `aws-base-accounts-init/*.tf` except `versions.tf` | Original account bootstrap, state, OIDC and IAM code; profile names and repository metadata sanitized | Unconfirmed; source contained no license grant |
| `aws-github-roles/*.tf` except `versions.tf` | Original role-chain code; account IDs, bootstrap repository and state prefix made configurable | Unconfirmed; source contained no license grant |
| `aws-github-roles/modules/attach_iam_policies/*.tf` | Complete original module; state-resource names parameterized | Unconfirmed; source contained no license grant |
| `aws-base-accounts-init/aws-account-infra-github-oidc.tf` | Source comments cite GitHub OIDC guidance and a third-party OIDC module as inspiration | Also review attribution and possible third-party licensing obligations before distribution |
| Three `.terraform.lock.hcl` files | Copied byte-for-byte, including selected AWS provider versions and package hashes | Dependency metadata; actual provider binaries are not distributed |
| `versions.tf` in each root | Added explicit exact AWS version constraints matching each existing lockfile | New extraction configuration; no provider upgrade |
| `terraform.tfvars.example`, `backend.hcl.example` | New examples, not copies of the private input inventories | Newly authored examples with fictitious values |
| README, docs, script, ignore file and CI | New standalone project documentation/tooling; CI follows the existing workflow structure | No blanket license has been assigned to the combined project |

No LICENSE is added because the right to license the source-derived implementation
has not been established. Being the author during employment, anonymizing values
or changing identifiers does not itself confirm redistribution rights. Obtain the
rightsholder's permission or exclude any uncleared code before public release.
This flag applies to **all extracted Terraform**, including the original policy
module; sanitization is not a legal clearance.

## Sanitization and narrowly scoped code changes

- Real organization name/domain, account email addresses, AWS account IDs, local
  profile names and repository/state-resource identifiers were removed.
- `aws-base/aws-account-*.tf` now builds the same seven email local parts using
  `var.account_email_domain` rather than an internal hard-coded domain.
- `aws-base-accounts-init/providers.tf` keeps all seven aliases and their use of
  AWS profiles, but reads names from `var.account_profiles`.
- `aws-github-roles/providers.tf` keeps the original infra/default credential
  flow and six target assume-role blocks. IDs use `var.account_ids`; bootstrap
  role names use `var.bootstrap_repository`. Metadata/session names use the new
  project name.
- The state policy module and all seven parent module calls share
  `var.terraform_state_prefix`, replacing the same fixed bucket/lock-table prefix.
- Provider versions 5.70.0, 5.98.0 and 6.35.1 remain associated with the same roots.
  No provider lockfile was regenerated or registry identifier rewritten.
- Original tfvars, including the private GitHub repository and team inventories,
  were not copied. Small, consistent examples use `example-org`, documentation
  email domains, generic group/profile/repository names and fictitious account IDs.
- Formatting was normalized in the destination only. Empty source `outputs.tf`
  remains empty; no fictional outputs or integrations were added.

No corporate workflow, private reusable action dependency, PAT, AWS credentials,
state, saved plan, provider binary, `.terraform` directory, source Git history or
provider cache was transferred. Public AWS/GitHub documentation links and the
GitHub OIDC issuer are intentionally retained.

## Architecture and security observations

The source has no OUs, SCPs, delegated security administrators, CloudTrail trails,
GuardDuty detectors or Security Hub service configuration. Documentation describes
Organizations trusted access and IAM permissions without presenting them as those
missing features. The seven account declarations, original `close_on_deletion`,
local bootstrap states, S3/DynamoDB backend and broad IAM privileges are retained
and documented rather than silently redesigned.

The original role-session trust restrictions and permissive OIDC subject patterns
are unchanged. Account/profile/root/SSO prerequisites, account adoption and IAM
policy safety require operator review in the real AWS environment.

## Source integrity and history

Source file checksums were captured before extraction and compared after the work.
The destination's pre-existing Git directory was not replaced; its existing
README title was expanded. No commit, remote creation, push, Terraform plan or
apply was performed. The source repository was not modified.

Secret scanning of current files does not remove secrets from previous histories.
The included CI scans full fetched Git history as well as files. Review this
repository's existing history and any prior exposure separately; source histories
were not imported into this project.
