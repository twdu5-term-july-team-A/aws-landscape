variable "cohort" {
  description = "Training cohort, eg: london-summer-2018"
}

variable "aws_region" {
  description = "Region in which to build resources."
}

variable "emr_cluster" {
  type = "map"
  default = {
    "master_type" = "m1.medium"
    "core_type"   = "m1.medium"
    "core_count"  = "2"
  }
}

variable "default_cohort" {
  description = "Default cohort name to get network information"
}
variable "env" {
  description = "The Environment on which the script is running"
}
