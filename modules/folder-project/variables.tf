variable "folder_id" {
    description = "the parent folder id to create this project into"
}

variable "name" {
    description = "The name and project_id of the project"
}

variable "billing_account" {
    description = "The billing account to associate with this project"
}

variable "labels" {
    description = "Additional labels to place on the project. managed-by: terraform will be automatically applied"
    type        = map(string)
    default     = {}
}

variable "activate_apis" {
    description = "APIs to activate for the project"
    default = []
}
