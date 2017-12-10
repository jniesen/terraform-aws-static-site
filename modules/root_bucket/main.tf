data "template_file" "content_policy" {
  template = "${file("${path.module}/templates/content_policy.json.tpl")}"
  vars {
    bucket_name = "${var.bucket_name}"
  }
}

resource "aws_s3_bucket" "root" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"
  policy = "${data.template_file.content_policy.rendered}"

  website {
    index_document = "index.html"
  }

  tags {
    Name = "${var.bucket_name}"
  }
}

resource "aws_route53_record" "root" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.bucket_name}"
  type    = "A"

  alias {
    name                   = "${aws_s3_bucket.root.website_domain}"
    zone_id                = "${aws_s3_bucket.root.hosted_zone_id}"
    evaluate_target_health = true
  }
}
