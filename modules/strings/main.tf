data "template_file" "domain_name" {
  template = "$${domain}.$${tld}"

  vars {
    domain    = "${var.domain}"
    tld       = "${var.tld}"
  }
}

data "template_file" "fqdn" {
  template = "$${subdomain}.$${domain_name}"

  vars {
    subdomain   = "${var.subdomain}"
    domain_name = "${data.template_file.domain_name.rendered}"
  }
}

data "template_file" "proto_url" {
  count    = "${var.force_www ? 1 : 0}"
  template = "$${protocol}://$${fqdn}"

  vars {
    protocol = "${var.force_https ? "https" : "http"}"
    fqdn      = "${data.template_file.fqdn.rendered}"
  }
}
