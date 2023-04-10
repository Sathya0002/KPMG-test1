variable "gregion" {
  type = string
  default = "us-east1"
}

variable "gzone" {
  type = string
  default = "us-east1-b"
}

variable "gproject" {
  type = string
  default = "temporal-data-382411"
}

variable "gcredential" {
  type = string
  default = "temporal-data-382411-38a872567689.json"
}

variable "gvpc" {
  type = string
  default = "newcustomvpc"
}

variable "gsubnets" {
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

variable "gsnweb" {
  type = string
  default = "subnet-1"
}

variable "gsnapp" {
  type = string
  default = "subnet-2"
}

variable "gsndb" {
  type = string
  default = "subnet-3"
}


# Variables
variable "web_instance_count" {
  default = 2
}

# Variables
variable "app_instance_count" {
  default = 2
}

# Variables
variable "db_instance_count" {
  default = 1
}