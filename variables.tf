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
  description = "The absolute path to the site's source files on your local machine."
  default = "false"
}

variable "deploy_content" {
  description = "Whether this module should manage site deployment. Default: false (it should not)."
  default = "false"
}

#
# REQUIRED
#
variable "domain" {
  description = "The domain part of the static site url. Required."
}
