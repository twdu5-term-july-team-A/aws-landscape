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
    instance_count = 1
    region = "ap-southeast-1"
    ebs_volume_size = 8
    ebs_volume_count = 1
    private_key = "tw-dataeng-twdu5-term-july-team-a"
  }
}

variable "default_cohort" {
  description = "Default cohort name to get network information"
}
variable "env" {
  description = "The Environment on which the script is running"
}
