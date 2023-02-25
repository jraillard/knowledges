# `Dummy Terraform`

This project have for only purpose to discover `Terraform` tool in order to provision infrastructure with code through the `HCL` language.

For further information about this stacks see :

- [HCL cheat sheet](../../cheat-sheets/langages/hcl.md)
- [Terraform cheat sheet](../../cheat-sheets/tools/hashicorp/terraform.md)
- [Terraform official doc](https://developer.hashicorp.com/terraform/registry/providers/docs)

---

## Content

My dummy infrastructure is made of :

- an [azure resource group](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal) ;

  > Allowing us to store all of our resources together

- an [azure app service](https://azure.microsoft.com/en-us/products/app-service/) running on windows and inside of an azure app plan (azure mandatory feature) ;

  > Allowing us to host our web app (as it's not the purpose of this lab there's not but you got the point :bulb:)
  > **See app_settings too** :eyes:

  &rarr; We get the storage account primary by calling the key vault instead of just copy it here :bulb:

- an [azure storage account](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview) ;

  > Allowing us to store some data

- an [azure key vault](https://learn.microsoft.com/en-us/azure/key-vault/general/basic-concepts).
  > Allowing us to store the storage account primary key in a secure way (as it is a sensible secret)

## Execution

Nothing special :wink:

> Juste be aware about being logged on correct Azure subscription with `az login` command

Then follow common instructions :

```PowerShell
# Getting providers & modules
terraform init

# Creating plan and check everything's alright !
terraform plan

# Provision all resources on you Azure subscription
terraform apply
```

## :warning: Don't forget to destroy all your resources after testing :warning:

```
terraform destroy
```
