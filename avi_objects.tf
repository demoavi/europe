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
    availability_zone = var.avi_vsvip.availability_zone
    enabled = true
    ipam_network_subnet {
      subnet {
        mask = var.avi_vsvip.mask
        ip_addr {
          type = var.avi_vsvip.type
          addr = var.avi_vsvip.addr
        }
      }
    }
  }
  dns_info {
    fqdn = "${var.avi_vsvip.basename}${count.index + 1 }.${var.avi_domain_name}"
  }
}

resource "avi_virtualservice" "https_vs" {
  count = var.avi_count
  name = "${var.avi_virtualservice.basename}${count.index + 1 }"
  pool_ref = avi_pool.pool[count.index].id
  cloud_ref = data.avi_cloud.default_cloud.id
  tenant_ref = data.avi_tenant.tenant[count.index].id
  ssl_key_and_certificate_refs = [data.avi_sslkeyandcertificate.ssl_cert.id]
  ssl_profile_ref = data.avi_sslprofile.ssl_profile.id
  application_profile_ref = data.avi_applicationprofile.application_profile.id
  network_profile_ref = data.avi_networkprofile.network_profile.id
  vsvip_ref= avi_vsvip.vsvip[count.index].id
  services {
    port           = var.avi_virtualservice.port
    enable_ssl     = var.avi_virtualservice.ssl
  }
}
