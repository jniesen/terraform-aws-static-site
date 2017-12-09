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

resource "aws_s3_bucket" "root" {
  bucket = "${module.strings.domain_name}"
  acl    = "public-read"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
  "Sid":"PublicReadGetObject",
        "Effect":"Allow",
    "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${module.strings.domain_name}/*"
      ]
    }
  ]
}
EOF

  website {
    index_document = "index.html"
  }

  tags {
    Name = "${module.strings.domain_name}"
  }
}


resource "aws_s3_bucket" "www" {
  bucket = "${module.strings.fqdn}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${module.strings.domain_name}"
  }

  tags {
    Name = "${module.strings.fqdn}"
  }
}

data "aws_route53_zone" "main" {
  name = "${module.strings.domain_name}."
}

resource "aws_route53_record" "root" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${module.strings.domain_name}"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.root.website_domain}"
    zone_id                = "${aws_s3_bucket.root.hosted_zone_id}"
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${module.strings.fqdn}"
  type    = "CNAME"

  alias {
    name                   = "${aws_s3_bucket.www.website_endpoint}"
    zone_id                = "${aws_s3_bucket.www.hosted_zone_id}"
    evaluate_target_health = true
  }
}
