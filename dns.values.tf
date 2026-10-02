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
  dns_records: {
    base_domain = [
      {
        sub      = "subdomain" # optional; omit for the base domain
        type     = "record type"
        content  = "DNS record content" | [ "DNS record content 1", ... ]
        ttl      = 300         # optional; TTL in seconds
        priority = 10          # optional; record priority
        notes    = "..."       # optional; additional information
        key      = "..."       # optional; string to diff same domain+type records
      }, ...
    ], ...
  }
  */
  dns_records = {
    (var.base_domain) = [
      { type = "A", content = ["185.199.108.153", "185.199.109.153", "185.199.110.153", "185.199.111.153"] },
      { type = "AAAA", content = ["2606:50c0:8000::153", "2606:50c0:8001::153", "2606:50c0:8002::153", "2606:50c0:8003::153"] },
    ]
  }
}
