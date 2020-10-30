variable "environment" {
  description = "environment name"
  type        = string
}

variable "cidr_block" {
  description = "what address block the VPC will use"
  type        = string
}

variable "project" {
  description = "project tag"
  type        = string
}

variable "name" {
  description = "allows for additional sub-project naming"
  default     = "main"
  type        = string
}

variable "flow_loging_traffic_type" {
  description = "what traffic to log"
  default     = "REJECT"
  type        = string
}

variable "flow_logging_enabled" {
  description = "whether or not flow logging is enabled"
  default     = false
  type        = bool
}

variable "flow_logging_retention" {
  description = "retention period for flow logs"
  default     = 7
  type        = number
}
