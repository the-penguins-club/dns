locals {
  ns_records = {
    (var.base_domain) = [
      "curitiba.ns.porkbun.com",
      "fortaleza.ns.porkbun.com",
      "maceio.ns.porkbun.com",
      "salvador.ns.porkbun.com"
    ]
  }

  /*
  # this map defines multiple records in bulk
  bulk_records: {
    base_domain = [
      {
        sub      = "subdomain" # optional; omit for the base domain
        type     = "record type"
        content  = "DNS record content"
        ttl      = 300         # optional; TTL in seconds
        priority = 10          # optional; record priority
        note     = "..."       # optional; additional information
      },
      ...
    ],
    ...
  }
  */
  bulk_records = {
    (var.base_domain) = [
      { type = "A", content = "2.3.4.5" },
      { type = "AAAA", content = "cafe::::babe" },
      { sub = "subdomain", type = "AAAA", content = "cafe::::babe" }
    ]
  }
}
