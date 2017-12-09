module "site" {
  source      = "../../"
  domain      = "${var.domain}"
  tld         = "${var.tld}"
  force_https = "${var.force_https}"
}
