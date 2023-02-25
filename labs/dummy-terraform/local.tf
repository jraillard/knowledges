locals {
  # Resources names
  rg_group_name = join("-", ["rg", var.project_name])
  sa_name       = join("", ["dummyjrastorageaccount"])
  sp_name       = join("-", ["service-plan", var.project_name])
  wapp_name     = join("-", ["app-service", var.project_name])
}
