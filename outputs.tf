output "jenkis-url" {
  value = "URL access: ${aws_instance.jenkins.public_dns}:8080"
}

output "jenkis-ssh" {
  value = "SSH access: ssh -i key.pem ec2-user@${aws_instance.jenkins.public_dns}"
}
