variable "cohort" {
  description = "Training cohort, eg: london-summer-2018"
}

variable "aws_region" {
  description = "Region in which to build resources."
}

variable "kafka" {
  type = "map"
  default = {
    instance_type = "t2.medium"
  }
}

variable "default_cohort" {
  description = "Default cohort name to get network information"
}
variable "env" {
  description = "The Environment on which the script is running"
}
