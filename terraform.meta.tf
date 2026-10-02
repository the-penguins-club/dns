terraform {
  required_version = "~> 1.16.0"

  required_providers {
    porkbun = {
      source  = "jianyuan/porkbun"
      version = "~> 0.3.0"
    }
  }

}

# hydrated by PORKBUN_API_KEY/PORKBUN_SECRET_KEY env vars
provider "porkbun" {}
