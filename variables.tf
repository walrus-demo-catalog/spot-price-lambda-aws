# @options ["g4dn.xlarge","g4dn.2xlarge","g4dn.4xlarge","c5.2xlarge","c5.4xlarge","t2.2xlarge","t3.2xlarge"]
variable "instance_type" {
  type = string
  description = "Instance type"
  default = "g4dn.2xlarge"
}
