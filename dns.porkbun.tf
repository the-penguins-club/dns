locals {
  # converts the bulk_records map into a flattened map
  # keyed by subdomain.base_domain:record_type.key
  resolved_bulk_records = merge([
    for domain, record in local.bulk_records : {
      for entry in record :
      join(":", [
        try(entry.sub, "") != "" ? "${entry.sub}.${domain}" : domain,
        try(entry.key, "") != "" ? "${entry.type}.${entry.key}" : entry.type
        ]) => merge(entry, {
        domain    = domain
        subdomain = try(entry.sub, null)
      })
    }
  ]...)
}

resource "porkbun_domain_nameservers" "ns" {
  for_each    = local.ns_records
  domain      = each.key
  nameservers = each.value
}

resource "porkbun_dns_record" "bulk" {
  for_each  = local.resolved_bulk_records
  domain    = each.value.domain
  type      = each.value.type
  content   = each.value.content
  subdomain = try(each.value.sub, null)
  ttl       = try(each.value.ttl, null)
  priority  = try(each.value.priority, null)
  notes     = try(each.value.note, null)
}
