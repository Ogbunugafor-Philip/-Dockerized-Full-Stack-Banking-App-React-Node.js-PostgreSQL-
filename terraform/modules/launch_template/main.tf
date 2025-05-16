resource "aws_launch_template" "app_lt" {
  name_prefix   = "docker-app-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.ec2_sg_id]

  user_data = base64encode(<<-EOF
              #!/bin/bash
              yum update -y
              amazon-linux-extras install docker -y
              service docker start
              usermod -aG docker ec2-user
              docker login -u AWS -p $(aws ecr get-login-password --region ${var.aws_region}) ${var.ecr_url}
              docker pull ${var.ecr_url}/${var.backend_image}
              docker run -d -p 5000:5000 ${var.ecr_url}/${var.backend_image}
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "docker-app-instance"
    }
  }
}
