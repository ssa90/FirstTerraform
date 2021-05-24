provider "artifactory" {
  url      = "${var.artifactory_url}/artifactory"
  username = var.artifactory_username
  password = var.artifactory_password
}

data "artifactory_file" "azure_test_func" {
  repository      = "example-repo-local"       #required
  path            = "FirstFunc.zip" #required
  output_path     = "FirstFunc.zip" #optional, if not set only the metadata are accessible, otherwise it will download the file contents to the given path
  force_overwrite = true
}
