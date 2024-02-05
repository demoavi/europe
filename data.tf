data "avi_tenant" "tenant" {
  count = var.avi_count
  name = var.avi_tenant
}

data "avi_healthmonitor" "hm" {
  count = var.avi_count
  depends_on = [avi_healthmonitor.hm]
  name = "${var.avi_healthmonitor.basename}${count.index + 1 }"
}
