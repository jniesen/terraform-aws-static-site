provider "aws" {
  region = "${var.region}"
}

module "strings" {
  source = "modules/strings"

  subdomain   = "${var.subdomain}"
  domain      = "${var.domain}"
  tld         = "${var.tld}"
  force_https = "${var.force_https}"
  force_www   = "${var.force_www}"
}

data "aws_route53_zone" "main" {
  name = "${module.strings.domain_name}."
}

module "root" {
  source = "modules/root_bucket"

  r53_zone_id = "${data.aws_route53_zone.main.zone_id}"
  bucket_name = "${module.strings.domain_name}"
}

module "www" {
  source = "modules/www_bucket"

  r53_zone_id = "${data.aws_route53_zone.main.zone_id}"
  bucket_name = "${module.strings.fqdn}"
  root_name   = "${module.strings.domain_name}"
}

module "deploy" {
  source = "modules/deployment"

  deploy_content = "${var.deploy_content}"
  root_name      = "${module.strings.domain_name}"
  site_source    = "${var.site_source}"
}
