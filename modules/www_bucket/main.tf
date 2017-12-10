resource "aws_s3_bucket" "www" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"

  website {
    redirect_all_requests_to = "${var.root_name}"
  }

  tags {
    Name = "${var.bucket_name}"
  }
}

resource "aws_route53_record" "www" {
  zone_id = "${var.r53_zone_id}"
  name    = "${var.bucket_name}"
  type    = "CNAME"

  alias {
    name                   = "${aws_s3_bucket.www.website_endpoint}"
    zone_id                = "${aws_s3_bucket.www.hosted_zone_id}"
    evaluate_target_health = true
  }
}
