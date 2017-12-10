variable "r53_zone_id" {
  description = "The ID of the Route 53 Hosted Zone where record sets will be created."
}

variable "bucket_name" {
  description = "The name of the S3 bucket. Also used as the name of a Route 53 A record."
}
