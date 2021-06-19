include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:smsilva/infrastructure-modules.git//app?ref=v0.0.1"
}

locals {
  vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}

inputs = {
  name      = "iac-live-sandbox"
  location  = "${local.vars.location}"
}
