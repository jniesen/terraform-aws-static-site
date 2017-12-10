output "bucket" {
  value = {
    "id"                 = "${aws_s3_bucket.www.id}"
    "arn"                = "${aws_s3_bucket.www.arn}"
    "bucket_domain_name" = "${aws_s3_bucket.www.bucket_domain_name}"
    "hosted_zone_id"     = "${aws_s3_bucket.www.hosted_zone_id}"
    "region"             = "${aws_s3_bucket.www.region}"
    "website_endpoint"   = "${aws_s3_bucket.www.website_endpoint}"
    "website_domain"     = "${aws_s3_bucket.www.website_domain}"
  }
}
