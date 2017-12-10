#
# OPTIONAL
#
variable "region" {
  description = "The AWS region where resources will be created. Default: us-east-1."
  default     = "us-east-1"
}

variable "subdomain" {
  description = "The subdomain part of the static site url. Default: www"
  default     = "www"
}

variable "tld" {
  description = "The top level part of the static site url. Default: com"
  default     = "com"
}

variable "force_www" {
  description = "Whether requests without www should redirect to www. Default: true (they should)."
  default     = "true"
}

variable "force_https" {
  description = "Whether http request should redirect to https. Default: true (they should)."
  default     = "true"
}

variable "site_source" {
  description = "A local path to a website source that will be uploaded to S3. Default: false (site source is not managed)."
}

#
# REQUIRED
#
variable "domain" {
  description = "The domain part of the static site url. Required."
}
