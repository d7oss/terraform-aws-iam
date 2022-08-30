variable "name" {
  type = string
  description = "The username of the user. Unique per AWS account."
}

variable "pgp_key" {
  type = string
  description = "An ASCII PGP public key, or a keybase:username key ID, to decrypt secrets."
  default = null
}

variable "path" {
  type = string
  description = "A path to identify an organizational unit."
  default = "/"
}

variable "enable_console" {
  type = bool
  description = "Whether to create a login profile for web console access."
  default = false
}

variable "enable_cli" {
  type = bool
  description = "Whether to create an access key for CLI access."
  default = false
}

variable "allow" {
  type = map(object({
    actions = list(string)
    resources = list(string)
  }))
  description = "Map of allowed actions and resources."
  default = {}
}

variable "deny" {
  type = map(object({
    actions = list(string)
    resources = list(string)
  }))
  description = "Map of denied actions and resources."
  default = {}
}
