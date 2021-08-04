data "aws_caller_identity" "current" {}

variable "region" {
  default = "ap-northeast-1"
}

variable "profile" {
  default = "cloud02"
}

variable "project" {
  default = "scaffold"
}

variable "env" {
  default = "dev"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_key" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCilogV9oqu8RVQIYA1/f+Ii0gXc9+yX373oahQ5kV/TtPDyq6gK3KDQqIPqBjwFE0vlvTSGRhfWCIiYndnvkqSxJkN+9/JoW/DlmMy+S9IXsm/Z5paLlclwqoY8tYGii81Ghnbq54g+SVn00zOLF0DlWHwRCsp7J6Er7xB4Nkqg+5DYul6mvCg0OM8Qp5A1jmsVwamnE9qm0/8SEiF9RcL/w02CGAFZy51c19hgFpDbdEP0j2klvDHJXCcs9k+/di1qgiuQ/RZg5rNeNV7B3llL55EZJJhp4SAfAc2L2n9iMH7Zcb1DqBPLjGFds3H+UpxLugA+fKN3N/7o8r+ZEOgZFYTUPhM1Qot/Mlmx9lXFD2kVHJc6y8Gl37qkiNIGNCzlfRXveunvmNxX2iojqRpGxBbE+zF6NuT2vB5LVnNNPouqS92+SLU6o77qkACeZ3NZVFl2ePgZ2OylHwtTqqd4TobcBbSxQYRGRChyBcsF0jnKJB9KxEmQNVi2iJaVHk="
}

variable "db_user_name" {}

variable "db_user_password" {}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "my_domain" {}

variable "rails_master_key" {}
