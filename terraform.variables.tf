variable "base_domain" {
  type        = string
  description = "base domain used in dns record definitions."
  default     = "thepenguins.club"
}

variable "porkbun_api_key" {
  type        = string
  sensitive   = true
  description = "porkbun API key."
}

variable "porkbun_api_secret_key" {
  type        = string
  sensitive   = true
  description = "porkbun API secret key."
}
