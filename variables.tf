variable "enable_dns_hostnames" {
  type = bool
}

variable "common_tags" {
  type = map(any)
}


variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}


variable "public_subnets_tags" {
  type    = map(string)
  default = {}
}

variable "private_subnets_tags" {
  type    = map(string)
  default = {}
}

variable "database_subnets_tags" {
  type    = map(string)
  default = {}
}



variable "igw_tags" {
  type    = map(any)
  default = {}

}

variable "public_subnets_cidr" {
  type = list(any)
  validation {
    condition     = length(var.public_subnets_cidr) == 2
    error_message = "Please provide two public valid subnets cidr "
  }

}

variable "private_subnets_cidr" {
  type = list(any)
  validation {
    condition     = length(var.private_subnets_cidr) == 2
    error_message = "Please provide two private valid subnets cidr "
  }

}

variable "database_subnets_cidr" {
  type = list(any)
  validation {
    condition     = length(var.database_subnets_cidr) == 2
    error_message = "Please provide two database valid subnets cidr "
  }

}

variable "nat_gateway_tags" {
  type    = map(string)
  default = {}
}

variable "public_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "private_route_table_tags" {
  type    = map(string)
  default = {}
}

variable "database_route_table_tags" {
  type    = map(string)
  default = {}
}

