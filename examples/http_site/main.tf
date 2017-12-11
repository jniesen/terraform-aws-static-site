module "site" {
  source      = "../../"
  domain      = "${var.domain}"
  tld         = "${var.tld}"
}
