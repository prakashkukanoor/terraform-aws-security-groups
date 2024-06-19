variable "environment" {
  type = string
}

variable "team" {
  type = string
}
variable "public_access_sg" {
  type = bool
  default = false
}

variable "ingress_rules" {
  type = map(object({
    port = string
    protocol = string
    cidr_ipv4 = list(string)
  }))
}