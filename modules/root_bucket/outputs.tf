output "bucket" {
  value = {
    "id"                 = "${aws_s3_bucket.root.id}"
    "arn"                = "${aws_s3_bucket.root.arn}"
    "bucket_domain_name" = "${aws_s3_bucket.root.bucket_domain_name}"
    "hosted_zone_id"     = "${aws_s3_bucket.root.hosted_zone_id}"
    "region"             = "${aws_s3_bucket.root.region}"
    "website_endpoint"   = "${aws_s3_bucket.root.website_endpoint}"
    "website_domain"     = "${aws_s3_bucket.root.website_domain}"
  }
}
