module "stdout_test" {
  source = "matti/resource/shell"
  command = "echo $USER | cut -c1-3"
}
output "vpc_network_id" {
  value = aws_vpc.eks_network.id
}
output "private_subnet_id" {
  value          = [for az, subnet in aws_subnet.private: subnet.id]
}
output "public_subnet_id" {
  value          = [for az, subnet in aws_subnet.public: subnet.id]
}
output "stdout_test" {
  value = module.stdout_test.stdout
}