data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn-hvm-openjdk8-java-1.8.0-2019.05.04-19.11"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["020014417079"]
}

data "template_file" "ec2_cloud_init" {
  template = "${file("${path.module}/script/install_jenkins.sh.tpl")}"

}

resource "tls_private_key" "my-key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "jenkins-key"
  public_key = "${tls_private_key.my-key.public_key_openssh}"
}

resource "aws_instance" "jenkins" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.jenkins-security-group.id}"]
  user_data              = "${data.template_file.ec2_cloud_init.rendered}"
  key_name               = "${aws_key_pair.generated_key.key_name}"

  tags = {
    Name = "jenkins server"
  }
}

resource "aws_security_group" "jenkins-security-group" {
  name = "jenkins-security-group"

  description = "ECS jenkins servers (terraform-managed)"
  vpc_id      = "vpc-ceb4a8a6"

  #ssh accessing port
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #ssh accessing port
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # web port
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "local_file" "key-file" {
    content     = "${tls_private_key.my-key.private_key_pem}"
    filename = "${path.module}/key.pem"
}