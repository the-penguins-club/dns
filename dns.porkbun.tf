locals {
  # converts the bulk_records map into a flattened map
  # keyed by subdomain.base_domain:record_type.key.index
  resolved_bulk_records = merge(flatten([
    for domain_name, records in local.bulk_records : [
      for rec in records : {
        for idx, content in can(distinct(rec.content)) ? flatten(rec.content) : flatten([rec.content]) :
        format(
          "%s.%s.%s",
          try(rec.sub, "") != "" ? "${rec.sub}.${domain_name}" : domain_name,
          rec.type,
          try(rec.key, "") != "" ? "${rec.key}.${idx}" : tostring(idx)
          ) => merge(rec, {
            domain    = domain_name
            subdomain = try(rec.sub, null)
            type      = rec.type
            content   = content
        })
      }
    ]
  ])...)

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
  subdomain = try(each.value.subdomain, null)
  ttl       = try(each.value.ttl, null)
  priority  = try(each.value.priority, null)
  notes     = try(each.value.notes, null)
}
