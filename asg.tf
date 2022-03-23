resource "aws_launch_template" "lt" {
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t3.nano"
  user_data     = filebase64("user-data.sh")
  key_name      = aws_key_pair.ssh.key_name
  instance_initiated_shutdown_behavior = "terminate"

  instance_market_options {
    market_type = "spot"
    spot_options {
        max_price = 0.002
    }
  }

  network_interfaces {
    associate_public_ip_address = true
  }

  placement {
    availability_zone = "${var.aws_region}a"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = random_uuid.id.result
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_size
  availability_zones   = ["${var.aws_region}a"]
  max_instance_lifetime= 86400

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}
