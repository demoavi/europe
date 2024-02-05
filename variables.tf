variable "avi_credentials" {}

variable "avi_tenant" {
  default = "admin"
}

variable "avi_cloud" {
  default = "Default-Cloud"
}

variable "avi_count" {
  default = 0
}

variable "avi_healthmonitor" {
  type = map
  default = {
    basename = "github-hm-"
    type = "HEALTH_MONITOR_HTTP"
    receive_timeout = "1"
    failed_checks = "2"
    send_interval= "1"
    successful_checks = "2"
    http_request= "HEAD / HTTP/1.0"
  }
}

variable "http_response_code" {
  type = list
  default = ["HTTP_2XX", "HTTP_3XX", "HTTP_5XX"]
}

variable "avi_servers" {
  default = [
    {
      ip = "10.0.2.117"
      type = "V4"
      port = "80"
    },
    {
      ip = "10.0.1.16"
      type = "V4"
      port = "80"
    },
    {
      ip = "10.0.1.52"
      type = "V4"
      port = "80"
    },
    {
      ip = "10.0.3.73"
      type = "V4"
      port = "80"
    }
  ]
}

variable "avi_pool" {
  type = map
  default = {
    basename = "github-pool-"
    lb_algorithm = "LB_ALGORITHM_ROUND_ROBIN"
  }
}
