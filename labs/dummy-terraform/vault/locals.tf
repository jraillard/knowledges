locals {
  # Resources names
  kv_name        = join("-", ["kv", var.project_name])
  kv_secret_name = join("-", ["kv-secret", var.project_name])
}
