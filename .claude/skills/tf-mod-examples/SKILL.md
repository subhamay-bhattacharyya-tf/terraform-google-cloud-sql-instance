---
name: tf-mod-examples
description: >
  Generates Terraform module example configurations covering all meaningful
  combinations of input variables. Use this skill when the user asks to
  generate examples, scaffold example directories, create tfvars combinations,
  or produce a complete examples/ folder for a Terraform module. Trigger when
  the user says "generate all examples", "scaffold examples", "create example
  combinations", or "fill in the examples directory". Also trigger when the
  user shares a variables.tf and asks for example usage across all options.
---

# Terraform Module Examples — Generator Skill

This skill generates a complete `examples/` directory tree for a Terraform
module by reading `variables.tf` and producing one standalone example per
meaningful feature combination.

---

## How to Use This Skill

1. Read `variables.tf` (and `versions.tf` if present) from the current module root.
2. Identify every optional field and enumerate its allowed values from `validation` blocks or type annotations.
3. Derive the example matrix using the rules below.
4. Write each example as a self-contained directory under `examples/` with its own `main.tf`, `variables.tf`, `terraform.tfvars`, and `README.md`.

---

## Step 1 — Enumerate Axes

For each optional field in the root `cloud_sql_database_instance_config` object, record:

| Axis | Values |
|---|---|
| `database_version` | `MYSQL_8_0`, `POSTGRES_15`, `POSTGRES_14`, `SQLSERVER_2019_STANDARD` |
| `location` | `us-central1`, `us-east1`, `us-east4`, `europe-west1` |
| `tier` | `db-f1-micro`, `db-g1-small`, `db-n1-standard-2`, `db-n1-standard-4` |
| `disk_type` | `PD_SSD`, `PD_HDD` |
| `availability_type` | `ZONAL`, `REGIONAL` |
| `disk_size` | `10`, `50`, `100` |
| `deletion_protection` | `true`, `false` |

---

## Step 2 — Example Matrix

Do **not** generate the full cartesian product. Instead produce these named
examples, each exercising a distinct capability or realistic deployment pattern:

| Directory | Purpose | Key axes exercised |
|---|---|---|
| `basic/` | Minimal required fields only | defaults everywhere |
| `mysql/` | MySQL 8.0 instance | `database_version=MYSQL_8_0`, `tier=db-n1-standard-2` |
| `postgres/` | PostgreSQL 15 instance | `database_version=POSTGRES_15`, `tier=db-n1-standard-2` |
| `sqlserver/` | SQL Server 2019 Standard | `database_version=SQLSERVER_2019_STANDARD` |
| `high-availability/` | Regional HA setup | `availability_type=REGIONAL`, `tier=db-n1-standard-4` |
| `with-hdd/` | HDD disk for cost savings | `disk_type=PD_HDD`, `disk_size=100` |
| `with-deletion-protection/` | Production guard | `deletion_protection=true` |
| `complete/` | All options specified | HA, large disk, deletion protection, custom tier |

---

## Step 3 — File Structure per Example

Each example directory must contain exactly these four files:

```
examples/<name>/
├── main.tf            # module call block only — no provider block
├── variables.tf       # re-declare only the variables consumed in main.tf
├── terraform.tfvars   # concrete values for every variable in variables.tf
└── README.md          # one-paragraph description + usage snippet
```

### `main.tf` template

```hcl
module "<name>" {
  source = "../../"

  environment  = var.environment
  project_code = var.project_code
  region       = var.region

  cloud_sql_database_instance_config = {
    base_name     = var.base_name
    # ... only include fields relevant to this example
  }
}
```

### `variables.tf` template

```hcl
variable "environment"  { type = string }
variable "project_code" { type = string }
variable "region"       { type = string  default = "us-central1" }
variable "base_name"    { type = string }
```

### `terraform.tfvars` template

```hcl
environment  = "devl"
project_code = "demo"
region       = "us-central1"
base_name    = "<example-slug>"
```

### `README.md` template

```markdown
# <Example Title>

One sentence describing what this example demonstrates.

## Usage

\`\`\`bash
terraform init -backend=false
terraform validate
\`\`\`
```

---

## Step 4 — Validation Rules

After writing all files:

1. Run `terraform fmt -recursive examples/` to format all generated files.
2. Run `terraform init -backend=false && terraform validate` inside each example directory and report any errors.
3. Fix any errors before returning.

---

## Step 5 — Output Summary

After all files are written and validated, print a table:

| Example | Files written | Validated |
|---|---|---|
| `basic/` | 4 | ✓ |
| ... | ... | ... |
