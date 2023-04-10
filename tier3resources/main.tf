terraform {
  required_version = ">= 0.13"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 3.50"
    }
  }
  backend "gcs" {
    bucket = "kpmg002"
    prefix = "terraform/state"
    credentials = "temporal-data-382411-38a872567689.json"
  }
}

# Provider Configuration
provider "google" {
  region      = var.gregion
  project     = var.gproject
  credentials = file(var.gcredential)
  zone = var.gzone
}

# Resources
# Create a VPC network
# Create multiple subnets
module network {
  source = "./network"
  gvpc = var.gvpc  
  subnets = var.gsubnets
}

# web instance template
# different instance templates for web, app and db
module web_instance_template {
  source = "./templateinstance"
  name_prefix = "web"
  tag = "web"
  machine_type = "n1-standard-1"
  source_image = "debian-cloud/debian-11"
  ssh_key = ""
  vpc = module.network.vpc_self_link 
  subnet = module.network.subnet_self_links[var.gsnweb]
}

# app instance template
module app_instance_template {
  source = "./templateinstance"
  name_prefix = "app1"
  tag = "app1"
  machine_type = "n1-standard-2"
  source_image = "debian-cloud/debian-11"
  ssh_key = ""
  vpc = module.network.vpc_self_link  
  subnet = module.network.subnet_self_links[var.gsnapp]
}

# db instance template
module db_instance_template {
  source = "./templateinstance"
  name_prefix = "db1"
  tag = "db1"
  machine_type = "n1-standard-2"
  source_image = "debian-cloud/debian-11"
  ssh_key = ""
  vpc = module.network.vpc_self_link 
  subnet = module.network.subnet_self_links[var.gsndb]
}

# create web servers and firewall
module web_server {
  source = "./servers"
  name_prefix = "web"
  tag = "web"
  protocol = "tcp"
  ports = "80"
  cidr = "0.0.0.0/0"
  vpc = module.network.vpc_self_link  
  subnet = module.network.subnet_self_links[var.gsnweb]
  instance_count = var.web_instance_count
  instance_template = module.web_instance_template.template_self_link
}

# create app servers and firewall
module app_server {
  source = "./servers"
  name_prefix = "app"
  tag = "app"
  protocol = "tcp"
  ports = "8080"
  cidr = "0.0.0.0/0"
  vpc = module.network.vpc_self_link  
  subnet = module.network.subnet_self_links[var.gsnapp]
  instance_count = var.app_instance_count
  instance_template = module.app_instance_template.template_self_link
}

# create db servers and firewall
module db_server {
  source = "./servers"
  name_prefix = "db"
  tag = "db"
  protocol = "tcp"
  ports = "3306"
  cidr = "0.0.0.0/0"
  vpc = module.network.vpc_self_link  
  subnet = module.network.subnet_self_links[var.gsndb]
  instance_count = var.db_instance_count
  instance_template = module.db_instance_template.template_self_link
}