variable "gvpc" {
  type = string
}

variable "subnets" {
  type = map(object({
    name          = string
    ip_cidr_range = string
    region        = string
  }))
  
  default = {
    subnet-1 = {
      name          = "subnet-1"
      ip_cidr_range = "10.0.1.0/24"
      region        = "us-east1"
    }
    subnet-2 = {
      name          = "subnet-2"
      ip_cidr_range = "10.0.2.0/24"
      region        = "us-east1"
    }
    subnet-3 = {
      name          = "subnet-3"
      ip_cidr_range = "10.0.3.0/24"
      region        = "us-east1"
    }
  }
}
