resource "avi_healthmonitor" "hm" {
  count = var.avi_count
  name = "${var.avi_healthmonitor.basename}${count.index + 1 }"
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

resource "avi_pool" "pool" {
  count = var.avi_count
  name = "${var.avi_pool.basename}${count.index + 1 }"
  tenant_ref = data.avi_tenant.tenant[count.index].id
  lb_algorithm = var.avi_pool.lb_algorithm
  cloud_ref = data.avi_cloud.default_cloud.id
  health_monitor_refs = ["${data.avi_healthmonitor.hm[count.index].id}"]
  dynamic servers {
    for_each = [for server in var.avi_servers:{
      addr = server.ip
      type = server.type
      port = server.port
    }]
    content {
      ip {
        type = servers.value.type
        addr = servers.value.addr
      }
      port = servers.value.port
    }
  }
}

resource "avi_vsvip" "vsvip" {
  count = var.avi_count
  name = "${var.avi_vsvip.basename}${count.index + 1 }"
  tenant_ref = data.avi_tenant.tenant[count.index].id
  cloud_ref = data.avi_cloud.default_cloud.id
  vip {
    vip_id = 1
    auto_allocate_floating_ip = true
    auto_allocate_ip = true
    availability_zone = "eu-west-2a"
    enabled = true
    ipam_network_subnet {
      network_ref = "https://europe.academy.demoavi.us/api/network/subnet-077f1b8c0cc96d74b"
      subnet {
        mask = 22
        ip_addr {
          type = "V4"
          addr = "10.0.20.0"
        }
      }
    }
  }
  dns_info {
    fqdn = "${var.avi_vsvip.basename}${count.index + 1 }.${var.avi_domain_name}"
  }
}
