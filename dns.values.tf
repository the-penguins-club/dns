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
