locals {
  ns_records = {
    (var.base_domain) = [
      "curitiba.ns.porkbun.com",
      "fortaleza.ns.porkbun.com",
      "maceio.ns.porkbun.com",
      "salvador.ns.porkbun.com"
    ]
  }

  # some utility values
  base_A = [
    "185.199.108.153",
    "185.199.109.153",
    "185.199.110.153",
    "185.199.111.153"
  ]
  base_AAAA = [
    "2606:50c0:8000::153",
    "2606:50c0:8001::153",
    "2606:50c0:8002::153",
    "2606:50c0:8003::153"
  ]

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
      { type = "A", content = local.base_A },
      { type = "AAAA", content = local.base_AAAA },
      { sub = "www", type = "CNAME", content = "the-penguins-club.github.io" },
      { sub = "wiki", type = "CNAME", content = "the-penguins-club.github.io" },
    ]
  }

  /*
  # this map defines forward records in bulk
  forward_records: {
    base_domain = [
      {
        sub           = "subdomain"  # optional; omit for the base domain
        location      = "target url"
        include_path  = false        # optional; include the path in the forward
        wildcard      = false        # optional; apply the forward to all subdomains
        type          = "temporary"  # optional; redirect type
        redirect_type = null         # optional; HTTP redirect type, overrides type if set
      }, ...
    ], ...
  }
  */
  forward_records = {
    (var.base_domain) = [
      { sub = "join", location = "https://t.me/+tzEXa1NQRv41MmU1" },
    ]
  }
}
