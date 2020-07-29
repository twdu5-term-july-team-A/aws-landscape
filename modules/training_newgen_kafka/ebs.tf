resource "aws_ebs_volume" "kafka-volume" {
  availability_zone = "${var.region}a"
  size = "${var.ebs_volume_size}"
  count = "${var.ebs_volume_count}"
  tags = "${merge(
    local.common_tags,
    map(
      "Name", "kafka-volume-${count.index}"
    )
  )}"
}