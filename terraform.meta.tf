terraform {
  required_version = "~> 1.16.0"

  required_providers {
    porkbun = {
      source  = "jianyuan/porkbun"
      version = "~> 0.3.0"
    }
  }
}

provider "porkbun" {
  api_key    = var.porkbun_api_key
  secret_key = var.porkbun_api_secret_key
}
