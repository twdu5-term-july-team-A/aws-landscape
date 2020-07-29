resource "aws_volume_attachment" "kafka-volume_attachment" {
  device_name = "/dev/sdh"
  count = 3
  volume_id   = "${element(aws_ebs_volume.kafka-volume.*.id, count.index)}"
  instance_id = "${element(aws_instance.kafka.*.id, count.index)}"
}