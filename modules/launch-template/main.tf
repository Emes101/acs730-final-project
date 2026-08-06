resource "aws_launch_template" "web" {
  name_prefix   = "${var.environment}-LaunchTemplate"
  image_id      = "ami-0c02fb55956c7d316"
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.instance_profile_name
  }

  vpc_security_group_ids = [
    var.web_security_group_id
  ]

  user_data = base64encode(<<EOF
#!/bin/bash

yum update -y
yum install -y httpd

systemctl start httpd
systemctl enable httpd

cat > /var/www/html/index.html <<HTML
<html>
<head>
<title>ACS730 Final Project</title>
</head>
<body>

<h1>Clement Okonkwo</h1>

<h2>ACS730 Terraform Project</h2>

<p>Website deployed using Terraform</p>

</body>
</html>
HTML

EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.environment}-WebServer"
    }
  }
}