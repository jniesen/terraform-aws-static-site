output "domain_name" {
  description = "Domain then dot then TLD. Ex: example.com"
  value = "${data.template_file.domain_name.rendered}"
}

output "fqdn" {
  description = "Subdomain then Domain Name. Ex: www.example.com"
  value = "${data.template_file.fqdn.rendered}"
}

output "proto_url" {
  description = "Protocol then FQDN. Ex: https://www.example.com"
  value = "${element(data.template_file.proto_url.*.rendered, 0)}"
}
