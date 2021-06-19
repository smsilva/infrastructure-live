include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:smsilva/infrastructure-modules.git//app?ref=v0.0.1"
}

locals {
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))
  location = local.region_vars.locals.location

  environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
  environment = local.environment_vars.locals.environment
}

inputs = {
  name      = "iac-live-${local.environment}"
  location  = "${local.location}"
}
