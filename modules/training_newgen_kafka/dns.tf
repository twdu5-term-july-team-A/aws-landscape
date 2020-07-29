resource "aws_route53_record" "kafka_newgen" {
  zone_id = "${var.dns_zone_id}"
  name    = "kafka${var.env == "prod" ? "" : "-${var.env}"}${count.index +1}"
  type    = "CNAME"
  ttl     = "60"
  allow_overwrite = true
  records = ["${aws_instance.kafka.*.private_dns[count.index]}"]
  count = 3
}
