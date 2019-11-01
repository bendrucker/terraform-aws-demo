output "url" {
  value = "http://${aws_instance.server.public_ip}:${var.port}"
}
