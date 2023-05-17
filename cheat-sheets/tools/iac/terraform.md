# Terraform

`Terraform` is an IaC (_infrastructure as code_) tool allowing you to create, update and version your cloud and / or on-premise resources.

`IaC` is basically code automating the manual work from Ops people related to application infrastructure.

:warning: Terraform is **used for provisionning** not for configuring or deploying :warning:

But some others can do it like [Bicep](https://learn.microsoft.com/fr-fr/azure/azure-resource-manager/bicep/overview?tabs=bicep). :eyes:

Terraform is exposed through a [cli](https://developer.hashicorp.com/terraform/cli) and a cloud developpment kit (but i don't recommend it as clic seems enough).

> :bulb:
> See [dummy-terraform](../../../labs/dummy-terraform/README.md) for a basic sample.

# Steps :paw_prints:

:one: `Write` desired infrastructure through tf project

:two: `Initialize` terraform project
by creating de **provider.tf** file with **terraform** block in order to instantiate the terraform project metadata with :

```powershell
terraform init
```

:three: `Write` your desired infrastructure

:four: `Plan` your desired infrastucture in order to get some feedbacks about what you're going to provision (resources created, property availables, incompatibility, etc.) :

```powershell
terraform plan
```

:five: `Apply` your desired infrastructure :

```powershell
terraform apply
```

:six: `Destroy` if needed (PoC, Application end of life, etc.) :

```powershell
terraform apply
```

# Terraform project content :pencil:

Following files are **used by covention** but you can basically have all your code in one single file : up to you :eyes:

## **.tfstate**

Known as the **state file**, it is used to store the state of the currently applied infrastructure.

You can also import the current state from an infrastructure as for retro-iac or debug cases :

```powershell
terraform import [options] ADDRESS ID
```

> In production mode, you might don't want to store it in you're project code, see the different [ways](https://developer.hashicorp.com/terraform/language/settings/backends/local) to do it.

## **provider.tf**

This file will contain :

- Terraform configuration :
  - version
  - state file location
- Required providers
  > Existing providers [list](https://registry.terraform.io/browse/providers)

## **variables.tf**

This file will contain all **dynamic data entries**.

`Variables` could be provided :

- as [cli arguments](https://developer.hashicorp.com/terraform/cli/commands/plan#input-variables-on-the-command-line)
- as environment variables, aka [TF_VAR](https://developer.hashicorp.com/terraform/cli/config/environment-variables)
- through .tfvars [definition files](https://developer.hashicorp.com/terraform/language/values/variables#variable-definitions-tfvars-files)

## **locals.tf**

This file will contain all **local** dynamic variables.

Only contain one "locals" block with all desired attributes.

## **main.tf**

It's the project entry point :door:

It contains :

- `resource` hcl blocks
- `data` hcl blocks

Every blocks can refer each others as Terraform will perform a graph at runtime and auto assigned values refered as element will be created :zap:

> It can also contain [modules](terraform.md#modules).

## **output.tf**

You may want display some data at runtime :question:

&rarr; output.tf file is for you !

Similar to **variables.tf**, every output specified will be printed at runtime so that you can for instance get the appservice you provisionned URI. :eyes:

## **modules**

Modules are a way to organize your terraform project :pencil:

At the beginning you only have one folder like following :

```
dummy-terraform
|   .terraform.lock.hcl
│   local.tf
│   main.tf
|   provider.tf
|   variables.tf
│
└───.terraform
│   │   ...
└───states (in local case for instance)
│   │   ...
```

but as you're project grows, your files might become less maintainable :skull:

That's why modules are made for ! :bulb:

You basically just have to :

- create a folder for your module whereever you want in you project hierarchy
- include files we mention before (_except for provider.tf_ dedicated to project init)
  > And that's it !

Terraform will consider it as a sub-project :

- **variables** will serves as module entries
- **locals** will only be available in the current module
- **output** will not be printed anymore but would be exposable through `callers`
  > **Callers** could be module or main project :bulb:

Callers will then just have to declare :

```terraform
module "my_module" {
  source = "./my_module"

  # Setting entry variables if needed
  # ...
  }
```

And use it :

```terraform
my_module_value = module.my_module.prop
```

# In real life :earth_africa:

Terraform supports **tons of providers** and there are **way more commands** available through the cli you might need as you will multiple terraform experiences

Terraform has quickly evolved and the tfstate file have changed a lot which could have lead to somme issues in past years.

> Good news, that's pretty not the case anymore and next updates are mainly **providers oriented** :sunny:

# Advices :brain:

:one: As you project grows, use [modules](terraform.md#modules) :exclamation:

:two: Follow **naming conventions** in order to communicate with other collaborators :loudspeaker:

:three: `Environment variables` and `cli arguments` can lead to headaches is CI/CD context for instance :dizzy_face:

&rarr; As a solution, think about use a **definition variable file** named `extra-variables.tfvars` :

- It should **never** be edited manually
- It will contain every variables needed for you CI-CD
- You're CI-CD will then only have to concatenate the variables it should send to the terraform project

> You could possibly do it in your CI-CD pipeline by calling a simple powershell script :

```powershell
# Getting needed attributes in $results
# ...

$resultFilePath = Join-Path (Resolve-Path .) "extra-variables.tfvars";

foreach($result in $results)
{
    if($null -ne $result){
        Write-Host "--------------------"
        Write-Host "Add $($result.name) to extra vars."
        Out-IniFile -Append -Encoding "UTF8" -FilePath $resultFilePath -InputObject @{ $result.name = $result.value }
    }
}
```

# To go further :muscle:

- Handle multiples azure tenants / subscriptions into a single terraform project &rarr; See [this](https://jeffbrown.tech/terraform-azure-multiple-subscriptions/) article.

&rarr; Basically add tenantId / subscriptionId in `azurerm` provider 
