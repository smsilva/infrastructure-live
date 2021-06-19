include {
  path   = find_in_parent_folders()
  expose = true
}

terraform {
  source = "git::git@github.com:smsilva/infrastructure-modules.git//app?ref=v0.0.1"
}

inputs = {
  name     = "iac-live-${include.inputs.environment}"
  location = "${include.inputs.location}"
}
