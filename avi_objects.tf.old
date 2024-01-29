resource "avi_healthmonitor" "hm" {
  count = var.avi_count
  name = "${var.avi_healthmonitor.basename}${count.index}"
  tenant_ref = data.avi_tenant.tenant[count.index].id
  type = var.avi_healthmonitor.type
  receive_timeout = var.avi_healthmonitor.receive_timeout
  failed_checks = var.avi_healthmonitor.failed_checks
  send_interval = var.avi_healthmonitor.send_interval
  successful_checks = var.avi_healthmonitor.successful_checks
  http_monitor {
    http_request = var.avi_healthmonitor.http_request
    http_response_code = var.http_response_code
  }
}
