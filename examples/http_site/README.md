# HTTP Site

This simple example of the AWS Static Site Terraform module shows how to serve
a site over HTTP.

To try the example out, create a `terraform.tfvars` file in the same directory
as this `README.md` file. The example requires that you have a Hosted Zone
already configured in AWS for a domain name that you own.

Sample `terraform.tfvars` file for a site hosted at example.org:

```
domain="example"
tld="org"
force_https="false"
```

Once you've populated a `terraform.tfvars` with your values, go ahead and run a
`terraform apply .`.
