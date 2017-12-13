module "site" {
  source         = "../../"
  domain         = "${var.domain}"
  tld            = "${var.tld}"
  deploy_content = "true"
  site_source    = "${path.module}/site"
}
