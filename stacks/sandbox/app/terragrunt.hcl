terraform {
  source = "git::git@github.com:smsilva/infrastructure-modules.git//app?ref=v0.0.1"
}

include {
  path   = find_in_parent_folders()
  expose = true
}

inputs = {
  name     = "iac-live-${include.inputs.environment}"
  location = "${include.inputs.location}"
}
