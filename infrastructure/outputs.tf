output "manager_public_ip" {
  value = aws_instance.manager.public_ip
}

output "workers_public_ip" {
  value = [for w in aws_instance.workers : w.public_ip]
}
