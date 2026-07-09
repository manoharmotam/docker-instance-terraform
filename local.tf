locals {
    ami = data.aws_ami.ami_id.id
  vpc_id = data.aws_vpc.main.id
  my_ip = ["${chomp(data.http.my_ip.response_body)}/32"]
}