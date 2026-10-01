locals {
  ns_records = {
    (var.base_domain) = [
      "curitiba.ns.porkbun.com",
      "fortaleza.ns.porkbun.com",
      "maceio.ns.porkbun.com",
      "salvador.ns.porkbun.com"
    ]
  }
}

resource "porkbun_domain_nameservers" "ns" {
  for_each    = local.ns_records
  domain      = each.key
  nameservers = each.value
}
