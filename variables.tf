variable "avi_credentials" {}

variable "avi_tenant" {
  default = "admin"
}

variable "avi_cloud" {
  default = "Default-Cloud"
}

variable "healthmonitor" {
  type = map
  default = {
    basename = "github-hm-"
    count = 1
    type = "HEALTH_MONITOR_HTTP"
    receive_timeout = "1"
    failed_checks = "2"
    send_interval= "1"
    successful_checks = "2"
    http_request= "HEAD / HTTP/1.0"
  }
}
