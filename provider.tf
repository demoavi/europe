provider "avi" {
  avi_username   = var.avi_credentials.username
  avi_password   = var.avi_credentials.password
  avi_controller = var.avi_credentials.controller
  avi_version    = var.avi_credentials.api_version
}

terraform {
  required_providers {
    avi = {
      source = "vmware/avi"
      version = "22.1.4"
    }
  }
}
