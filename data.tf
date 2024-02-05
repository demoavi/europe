data "avi_tenant" "tenant" {
  depends_on = [avi_tenant.tenant]
  count = var.avi_create == true ? length(var.attendees_list) : 0
  name = "${var.avi_tenant.basename}${count.index + 1 }"
}

data "avi_cloud" "default_cloud" {
  name = var.avi_cloud
}

data "avi_sslkeyandcertificate" "ssl_cert" {
  name = var.avi_virtualservice.sslCert
}

data "avi_sslprofile" "ssl_profile" {
  name = var.avi_virtualservice.sslProfile
}

data "avi_applicationprofile" "application_profile" {
  name = var.avi_virtualservice.applicationProfile
}

data "avi_networkprofile" "network_profile" {
  name = var.avi_virtualservice.networkProfile
}
