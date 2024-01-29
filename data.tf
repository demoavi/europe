data "avi_tenant" "tenant" {
  count = var.avi_count
  name = var.avi_tenant
}
