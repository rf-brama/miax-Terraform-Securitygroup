provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "remote" {
  backend = "s3"
  config = {
    bucket = "miax-state-files"
    key = "VPC/terraform.tfstate"
    region = "us-east-1"
  }
}
resource "aws_security_group" "Open-Security-Group" {
  name = "Open-Security-Group"
  vpc_id      = "${data.terraform_remote_state.remote.outputs.module_vpc3_vpc_id}"

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
      ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
      ingress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
      ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    ingress {
    from_port = 9092
    to_port   = 9092
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    ingress {
    from_port = 9094
    to_port   = 9094
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    ingress {
    from_port = 2181
    to_port   = 2181
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    ingress {
    from_port = 2182
    to_port   = 2182
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    ingress {
    from_port = 11001
    to_port   = 11001
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    ingress {
    from_port = 11002
    to_port   = 11002
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }  
    egress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
      egress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
      egress {
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
      egress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 9092
    to_port   = 9092
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 9094
    to_port   = 9094
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 2181
    to_port   = 2181
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 2182
    to_port   = 2182
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 11001
    to_port   = 11001
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 11002
    to_port   = 11002
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }  
    tags = {
    Name       = "Open-Security-SGT"
    Department = "Infrastructure"
  }
}
resource "aws_security_group" "DB-Security-Group" {
  name = "DB-Security-Group"
  vpc_id      = "${data.terraform_remote_state.remote.outputs.module_vpc3_vpc_id}"
    ingress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    egress {
    from_port = 3306
    to_port   = 3306
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
    tags = {
    Name       = "DB-Security-SG"
    Department = "Infrastructure"
  }
}
resource "aws_security_group" "kafka" {
  name_prefix = "Kafka-Security-Group"
  vpc_id      = "${data.terraform_remote_state.remote.outputs.module_vpc3_vpc_id}"
    tags = {
    Name       = "kafka-Security-SG"
    Department = "Infrastructure"
  }
}
resource "aws_security_group_rule" "msk-plain" {
  from_port         = 9092
  to_port           = 9092
  protocol          = "tcp"
  security_group_id = aws_security_group.kafka.id
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "msk-tls" {
  from_port         = 9094
  to_port           = 9094
  protocol          = "tcp"
  security_group_id = aws_security_group.kafka.id
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "zookeeper-plain" {
  from_port         = 2181
  to_port           = 2181
  protocol          = "tcp"
  security_group_id = aws_security_group.kafka.id
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "zookeeper-tls" {
  from_port         = 2182
  to_port           = 2182
  protocol          = "tcp"
  security_group_id = aws_security_group.kafka.id
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "jmx-exporter" {
  from_port         = 11001
  to_port           = 11001
  protocol          = "tcp"
  security_group_id = aws_security_group.kafka.id
  type              = "ingress"
  self              = true
}

resource "aws_security_group_rule" "node_exporter" {
  from_port         = 11002
  to_port           = 11002
  protocol          = "tcp"
  security_group_id = aws_security_group.kafka.id
  type              = "ingress"
  self              = true
}
resource "aws_security_group_rule" "DB_Connector" {
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  type              = "egress"
  security_group_id = aws_security_group.kafka.id 
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

