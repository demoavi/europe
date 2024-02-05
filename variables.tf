variable "avi_credentials" {}

variable "attendees_list" {}

variable "avi_tenant" {
  type = map
  default = {
    basename = "tenant00"
    default = "admin"
  }
}

variable "avi_cloud" {
  default = "Default-Cloud"
}

variable "avi_create" {
  default = true
}

variable "avi_healthmonitor" {
  type = map
  default = {
    basename = "github-hm"
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
    basename = "github-pool"
    lb_algorithm = "LB_ALGORITHM_ROUND_ROBIN"
  }
}

variable "avi_vsvip" {
  type = map
  default = {
    basename = "github-vsvip"
    availability_zone = "eu-west-2a"
    addr = "10.0.20.0"
    mask = 22
    type = "V4"
  }
}

variable "avi_domain_name" {
  default = "demoavi.us"
}

variable "avi_virtualservice" {
  type = map
  default = {
    basename = "github-vs"
    port = "443"
    ssl = "true"
    applicationProfile = "System-Secure-HTTP"
    networkProfile = "System-TCP-Proxy"
    sslProfile = "System-Standard"
    sslCert = "System-Default-Cert"
  }
}
