resource "porkbun_domain_nameservers" "ns" {
  for_each    = local.ns_records
  domain      = each.key
  nameservers = each.value
}
