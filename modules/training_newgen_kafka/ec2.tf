resource "aws_instance" "kafka" {
  count                  = "${var.instance_count}"
  ami                    = "${data.aws_ami.training_newgen_kafka.image_id}"
  instance_type          = "${var.instance_type}"
  vpc_security_group_ids = ["${aws_security_group.kafka.id}"]
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.ec2_key_pair}"
  iam_instance_profile   = "${aws_iam_instance_profile.kafka.name}"
  user_data              = <<-EOF
                        #!/usr/bin/env bash
                        # mount the additional volume
                        mkfs -t xfs /dev/xvdh
                        mkdir /data
                        mkdir /data/kafka
                        mount /dev/xvdh /data

                        # configure zookeeper properties
                        systemctl stop confluent-kafka
                        sleep 30
                        systemctl stop confluent-zookeeper

                        rm -rf /var/lib/zookeeper/version-2/*

                        echo "${count.index+1}" > /var/lib/zookeeper/myid
                        chown cp-kafka:confluent /var/lib/zookeeper/myid

                        echo "server.1=kafka-test1.${var.default_cohort}.training:2888:3888" >> /etc/kafka/zookeeper.properties
                        echo "server.2=kafka-test2.${var.default_cohort}.training:2888:3888" >> /etc/kafka/zookeeper.properties
                        echo "server.3=kafka-test3.${var.default_cohort}.training:2888:3888" >> /etc/kafka/zookeeper.properties

                        echo "initLimit=10" >> /etc/kafka/zookeeper.properties
                        echo "syncLimit=5"  >> /etc/kafka/zookeeper.properties

                        # configure kafka properties
                        sed -i -e "s|zookeeper.connect=localhost:2181|zookeeper.connect="kafka-test1.${var.default_cohort}.training:2181,kafka-test2.${var.default_cohort}.training:2181,kafka-test3.${var.default_cohort}.training:2181"|g" /etc/kafka/server.properties
                        sed -i -e "s|broker.id=0|broker.id=${count.index}|g" /etc/kafka/server.properties
                        sed -i -e "s|log.dirs=/var/lib/kafka|log.dirs=/data/kafka|g" /etc/kafka/server.properties

                        sleep 120
                        nohup /bin/zookeeper-server-start /etc/kafka/zookeeper.properties > /var/log/kafka/zookeeper${count.index+1}.log &
                        sleep 120
                        nohup /bin/kafka-server-start /etc/kafka/server.properties  > /var/log/kafka/kafka${count.index+1}.log &
                        EOF

  tags = "${merge(
    local.common_tags,
    map(
        "Name", "kafka-${var.deployment_identifier}-${count.index}"
    )
  )}"
}
