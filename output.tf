output "ssh_key_pair" {
  value = aws_key_pair.key_pair.id
}
output "public_ip" {
  value = aws_instance.demo.public_ip
}