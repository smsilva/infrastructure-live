include {
  path = find_in_parent_folders()
}

terraform {
  source = "git::git@github.com:smsilva/infrastructure-modules.git//app?ref=v0.0.1"
}

inputs = {
  name      = "iac-live-sandbox"
  location  = "centralus"
}
