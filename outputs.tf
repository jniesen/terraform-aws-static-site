output "www_bucket" {
  value = {
    "id"                 = "${module.www.bucket["id"]}"
    "arn"                = "${module.www.bucket["arn"]}"
    "bucket_domain_name" = "${module.www.bucket["bucket_domain_name"]}"
    "hosted_zone_id"     = "${module.www.bucket["hosted_zone_id"]}"
    "region"             = "${module.www.bucket["region"]}"
    "website_endpoint"   = "${module.www.bucket["website_endpoint"]}"
    "website_domain"     = "${module.www.bucket["website_domain"]}"
  }
}

output "root_bucket" {
  value = {
    "id"                 = "${module.root.bucket["id"]}"
    "arn"                = "${module.root.bucket["arn"]}"
    "bucket_domain_name" = "${module.root.bucket["bucket_domain_name"]}"
    "hosted_zone_id"     = "${module.root.bucket["hosted_zone_id"]}"
    "region"             = "${module.root.bucket["region"]}"
    "website_endpoint"   = "${module.root.bucket["website_endpoint"]}"
    "website_domain"     = "${module.root.bucket["website_domain"]}"
  }
}
