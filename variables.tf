output "target_group_arn" {
  value = "${aws_lb_target_group.test.id}"
}
output "loadbalancer_arn" {
  value = "${aws_lb.test.arn}"
}
variable "varversion" {}
variable "albname" {
  default = "ivr-alb"
}
variable "targetgroup" {
  default = "target-group-1"
}
variable "targetgrouptwo" {
  default = "target-group-2"
}
variable "targetgroupthree" {
  default = "target-group-3"
}
variable "Role" {
  default = "app"
}
variable "Vsad" {
  default = "PP4V"
}
variable "Userid" {
  default = "yanduna"
}
output "DNSname" {
  value = "${aws_lb.test.dns_name}"
}
