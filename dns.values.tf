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
        content  = "DNS record content" | [ "DNS record content 1", ... ]
        ttl      = 300         # optional; TTL in seconds
        priority = 10          # optional; record priority
        notes    = "..."       # optional; additional information
        key      = "..."       # optional; string to diff same domain+type records
      },
      ...
    ],
    ...
  }
  */
  bulk_records = {
    (var.base_domain) = [
      { type = "A", content = ["2.3.4.5", "5.6.7.8"] },
      { type = "AAAA", content = "cafe::::babe" },
      { sub = "subdomain", type = "AAAA", content = "cafe::::babe" },
      { type = "TXT", content = ["v=spf1 mx ~all", "v=spf1 include:_spf.example.com ~all"] },
      { type = "TXT", content = "openpgp4fpr:<keyid>", key = "openpgp" }
    ]
  }
}
