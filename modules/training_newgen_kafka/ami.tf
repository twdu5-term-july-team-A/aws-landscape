data "aws_ami" "training_newgen_kafka" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["data-eng-kafka-training-*"]
  }
}
