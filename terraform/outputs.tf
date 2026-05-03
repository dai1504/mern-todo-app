output "public_ip" {
  value = aws_instance.devops_server.public_ip
}

output "ssh_command" {
  value = "ssh -i devops-key.pem ubuntu@${aws_instance.devops_server.public_ip}"
}