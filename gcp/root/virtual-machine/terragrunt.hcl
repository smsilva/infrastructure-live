terraform {
  source = "git::git@github.com:smsilva/infrastructure-modules.git//gcp/compute-instance?ref=master"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name = "iac-live-${include.inputs.environment}-test"
}
