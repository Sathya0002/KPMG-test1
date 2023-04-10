variable name_prefix {
    type=string
}

variable vpc {
    type=string
}

variable protocol{
    type=string
}

variable ports {
    type=string
}

variable cidr {
    type=string
}

variable tag {
    type=string
}

variable subnet {
    type=string
}


# Variables
variable "instance_count" {
  type = number
  default = 1
}

# Variables
variable "instance_template" {
  type = string
}