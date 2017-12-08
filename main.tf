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

resource "aws_s3_bucket" "www" {
  bucket = "${module.strings.fqdn}"
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  tags {
    Name = "${module.strings.fqdn}"
  }
}

resource "aws_s3_bucket" "non_www" {
  count                    = "${var.force_www ? 1 : 0}"
  bucket                   = "${module.strings.domain_name}"
  acl                     = "public-read"

  website {
    redirect_all_requests_to = "${module.strings.proto_url}"
  }

  tags {
    Name = "${module.strings.domain_name}"
  }
}

data "aws_route53_zone" "main" {
  name = "${module.strings.domain_name}."
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${module.strings.fqdn}"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.www.website_endpoint}"
    zone_id                = "${aws_s3_bucket.www.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "non_www" {
  count   = "${var.force_www ? 1 : 0}"
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${module.strings.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.non_www.website_endpoint}"
    zone_id                = "${aws_s3_bucket.non_www.hosted_zone_id}"
    evaluate_target_health = true
  }
}
