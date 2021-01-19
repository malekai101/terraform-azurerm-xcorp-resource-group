
variable "project_name" {
  type        = string
  description = "The name of the project."
}

variable "project_environment" {
  type        = string
  description = "The type of project: [PROD|QA|DEV]"
}

variable "location" {
  type        = string
  description = "The location of the resources."
}

variable "admin_network" {
  type        = string
  description = "CIDR address of devices allowed SSH access"
}