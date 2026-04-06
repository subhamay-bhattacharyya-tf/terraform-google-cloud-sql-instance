# Terraform Module for Google Cloud SQL Database Instance

![Release](https://github.com/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance/actions/workflows/ci.yaml/badge.svg)&nbsp;![GCP](https://img.shields.io/badge/GCP-4285F4?logo=googlecloud&logoColor=white)&nbsp;![Commit Activity](https://img.shields.io/github/commit-activity/t/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance)&nbsp;![Last Commit](https://img.shields.io/github/last-commit/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance)&nbsp;![Release Date](https://img.shields.io/github/release-date/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance)&nbsp;![Repo Size](https://img.shields.io/github/repo-size/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance)&nbsp;![File Count](https://img.shields.io/github/directory-file-count/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance)&nbsp;![Issues](https://img.shields.io/github/issues/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance)&nbsp;![Top Language](https://img.shields.io/github/languages/top/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance)&nbsp;![Built with Claude Code](https://img.shields.io/badge/Built%20with-Claude%20Code-623CE4?logo=anthropic&logoColor=white)&nbsp;![Custom Endpoint](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/bsubhamay/476e6e7583432e960e6de16d5223e6a3/raw/terraform-google-cloud-sql-instance.json?&cacheSeconds=0)

A Terraform module for creating and managing a **Google Cloud SQL Database Instance** on GCP.

## Overview

This module provisions a single `google_sql_database_instance` resource. It accepts a single structured `cloud_sql_database_instance_config` object variable and exposes standard instance attributes as outputs.

## Requirements

| Requirement | Version |
| --- | --- |
| Terraform | >= 1.3.0 |
| Google Provider | >= 7.23.0 |

## Usage

```hcl
module "cloud_sql_database_instance" {
  source = "github.com/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance"

  environment  = "prod"
  project_code = "demo"
  region       = "us-central1"

  cloud_sql_database_instance_config = {
    base_name = "my-sql-instance"
    location  = "us-central1"
  }
}
```

## Input Variables

| Name | Description | Type | Default | Required |
| --- | --- | --- | --- | --- |
| `environment` | Deployment environment | `string` | — | yes |
| `project_code` | Short identifier for naming standardization | `string` | — | yes |
| `region` | GCP region | `string` | `"us-central1"` | no |
| `cloud_sql_database_instance_config` | Configuration object for the Cloud SQL database instance | `object` | — | yes |

### `cloud_sql_database_instance_config` Attributes

| Attribute | Type | Required | Default | Notes |
| --- | --- | --- | --- | --- |
| `base_name` | `string` | yes | — | Alphanumeric or dashes, max length ≤ 30 |
| `location` | `string` | no | `"us-central1"` | Region where the instance is created |

## Outputs

| Name | Description |
| --- | --- |
| `instance_id` | The ID of the Cloud SQL database instance |
| `instance_name` | The name of the Cloud SQL database instance |
| `instance_project` | The project ID where the instance is created |
| `instance_location` | The region of the Cloud SQL database instance |
| `instance_url` | The connection URL of the instance |
| `instance_self_link` | The self link of the Cloud SQL database instance resource |
| `instance_storage_class` | The storage class of the instance |
| `instance_force_destroy` | Whether force_destroy is enabled |

## CI / Workload Identity Federation Setup

The Terratest job authenticates to GCP via [Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation) (service account impersonation). If the job fails with `Permission 'iam.serviceAccounts.getAccessToken' denied`, grant the WIF pool principal the required IAM binding:

```bash
gcloud iam service-accounts add-iam-policy-binding \
    "sa-10-cloud-sql@prj-10-cloud-sql-16748.iam.gserviceaccount.com" \
    --project="prj-10-cloud-sql-16748" \
    --role="roles/iam.workloadIdentityUser" \
    --member="principalSet://iam.googleapis.com/projects/578842011545/locations/global/workloadIdentityPools/github-actions/attribute.repository/subhamay-bhattacharyya-tf/terraform-google-cloud-sql-instance"
```

The three repository variables required by the CI workflow are:

| Variable | Description |
| --- | --- |
| `GCP_PROJECT_ID` | GCP project ID passed as `GOOGLE_CLOUD_PROJECT` to Terratest |
| `GCP_WORKLOAD_IDENTITY_PROVIDER` | Full WIF provider resource name |
| `GCP_SERVICE_ACCOUNT` | Service account email to impersonate |

## License

Apache 2.0 — see [LICENSE](LICENSE).
