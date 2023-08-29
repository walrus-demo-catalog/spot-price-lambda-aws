# @options ["g4dn.xlarge","g4dn.2xlarge","g4dn.4xlarge"]
variable "instance_type" {
  type = string
  description = "Instance type"
  default = "g4dn.2xlarge"
}
