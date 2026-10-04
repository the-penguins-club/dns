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

  base_dkim = <<-EOT
    v=DKIM1; k=rsa; p=MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAryRI6+1rfPT9sN/G
    s5CrCte7wlW77KDmPiveikSW3KxdPW6UUbY13sJvMtRGO0MFXVqyvbMMPYrpBIInii0aVpx2Nz/iSC
    kg/9zvVSTkmU1hKNKe1nVTTo5E5Cu23zPh1Hy+eVke0QLS1yJvTbArFIQzPruptEynIXFIeNdo18VA
    WtiQ2WbIxuGc2SbBnLym0sJ5ri1dh6h/vg88kwaZ7m0Ss4RZNLyxbJQXCJHBCkHiiRqVyrJwQi966C
    3l+qGkg179Om/pcpkAKBOscOqz0aLbjxBtRts+YAlIKc/q68AW5j55ztb45Y4ZZixwX/x9TnFm1i7a
    HKtHvZbxS/I71QIDAQAB6
  EOT

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
      { type = "MX", content = "bdeshi.space", priority = 10 },
      { type = "TXT", content = "v=spf1 mx ~all", key = "spf" },
      { sub = "default._domainkey", type = "TXT", content = replace(local.base_dkim, "\n", "") },
      { sub = "_dmarc", type = "TXT", content = "v=DMARC1; p=none; rua=mailto:admin@${var.base_domain}" },
      { type = "TXT", content = ["anthropic-domain-verification-j540bn=IZ5fSvFWZn05shtTQxcgX5Hrw"], key = "verify" },
      { sub = "_gh-the-penguins-club-o", type = "TXT", content = "a80bc30083", notes = "github org verification record" }
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
