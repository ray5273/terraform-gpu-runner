# output "runner_asg_name" {
#   description = "Auto Scaling Group name for the GPU runners"
#   value       = module.github_runner.runners["gpu_pool"].asg_name
# }
#
# output "launch_template_id" {
#   description = "Launch template used by the GPU runner"
#   value       = module.github_runner.runners["gpu_pool"].launch_template_id
# }