variable "deployment_identifier" {
  description = "An identifier for this instantiation."
}

variable "vpc_id" {
  description = "VPC in which to provision Kafka"
}

variable "subnet_id" {
  description = "Subnet in which to provision Kafka"
}

variable "ec2_key_pair" {
  description = "EC2 key pair to use to SSH into Kafka instance"
}

variable "dns_zone_id" {
  description = "DNS zone in which to create records"
}

variable "instance_type" {
  description = "EC2 instance type for Kafka"
}

variable "instance_count" {
  description = "EC2 instance count for Kafka"
}

variable "bastion_security_group_id" {
  description = "Id of bastion security group to allow SSH ingress"
}


variable "bastion_ip_address" {
  description = "IP addresses of bastion servers"
}

variable "emr_security_group_id" {
  description = "Id of EMR cluster security group to Kafka & Zookeeper ingress"
}

variable "env" {
  description = "Environment on which the emr is created"
}

variable "region" {
  description = "AWS Region"
}

variable "ebs_volume_size" {
  description = "Volume for kafka EBS"
}

variable "ebs_volume_count" {
  description = "Number of EBS volumes for kafka"
}

variable "private_key" {
  type = "string"
  description = "local path to ssh private key"
}

variable "cohort" {
  description = "Cohort name"
}

variable "default_cohort" {
  description = "Cohort name"
}