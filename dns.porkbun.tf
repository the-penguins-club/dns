locals {
  # converts the dns_records map into a flattened map
  # keyed by subdomain.base_domain:record_type.key.index
  resolved_dns_records = merge(flatten([
    for domain_name, records in local.dns_records : [
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
    }]
  ])...)

  # converts the forward_records map into a flattened map
  # keyed by subdomain.base_domain
  resolved_forward_records = merge(flatten([
    for domain_name, records in local.forward_records : [
      for rec in records : {
        (rec.sub != "" ? "${rec.sub}.${domain_name}" : domain_name) = merge(rec, {
          domain    = domain_name
          subdomain = rec.sub
        })
    }]
  ])...)
}

resource "porkbun_domain_nameservers" "ns" {
  for_each    = local.ns_records
  domain      = each.key
  nameservers = each.value
}

resource "porkbun_dns_record" "dns" {
  for_each  = local.resolved_dns_records
  domain    = each.value.domain
  subdomain = try(each.value.subdomain, null)
  type      = each.value.type
  content   = each.value.content
  priority  = try(each.value.priority, null)
  ttl       = try(each.value.ttl, null)
  notes     = try(each.value.notes, null)
}

resource "porkbun_url_forward" "fwd" {
  for_each      = local.resolved_forward_records
  domain        = each.value.domain
  subdomain     = try(each.value.subdomain, null)
  location      = each.value.location
  include_path  = try(each.value.include_path, false)
  wildcard      = try(each.value.wildcard, false)
  type          = try(each.value.type, "temporary")
  redirect_type = try(tostring(each.value.redirect_type), null)
}
