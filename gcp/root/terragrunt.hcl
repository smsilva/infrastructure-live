remote_state {
  backend = "gcs"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket               = "silvios"
    prefix               = "${path_relative_to_include()}/state"
    skip_bucket_creation = true
  }
}

locals {
  account_vars       = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  region_vars        = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  environment_vars   = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  project            = local.account_vars.locals.project
  region             = local.region_vars.locals.region
  zone               = local.region_vars.locals.zone
  modules_repository = "git::git@github.com:smsilva/infrastructure-modules.git"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"

  contents = <<EOF
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.72.0"
    }
  }
}

provider "google" {
  project = "${local.project}"
  region  = "${local.region}"
  zone    = "${local.zone}"
}
EOF
}

inputs = merge(
  local.account_vars.locals,
  local.region_vars.locals,
  local.environment_vars.locals,
  local
)
