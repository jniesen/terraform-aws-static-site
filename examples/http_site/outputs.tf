output "www_bucket" {
  value = {
    "id"                 = "${module.site.www_bucket["id"]}"
    "arn"                = "${module.site.www_bucket["arn"]}"
    "bucket_domain_name" = "${module.site.www_bucket["bucket_domain_name"]}"
    "hosted_zone_id"     = "${module.site.www_bucket["hosted_zone_id"]}"
    "region"             = "${module.site.www_bucket["region"]}"
    "website_endpoint"   = "${module.site.www_bucket["website_endpoint"]}"
    "website_domain"     = "${module.site.www_bucket["website_domain"]}"
  }
}

output "root_bucket" {
  value = {
    "id"                 = "${module.site.root_bucket["id"]}"
    "arn"                = "${module.site.root_bucket["arn"]}"
    "bucket_domain_name" = "${module.site.root_bucket["bucket_domain_name"]}"
    "hosted_zone_id"     = "${module.site.root_bucket["hosted_zone_id"]}"
    "region"             = "${module.site.root_bucket["region"]}"
    "website_endpoint"   = "${module.site.root_bucket["website_endpoint"]}"
    "website_domain"     = "${module.site.root_bucket["website_domain"]}"
  }
}
