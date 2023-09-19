# Week 1 - Building Terrahouse

## Table of Contents

- [<ins></ins>]()


## Root Module
The root module structure shoud be:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Module Structure Guidelines](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

### Variables in Terraform Cloud

We can store Terraform Variables (e.g. vars set in .tfvars file) or Environment Variables (e.g. vars set in bash terminal, AWS Credentials).

These can be set to sensitive to avoid exposure.

### (IDE...) Loading Terraform Input Variables
Variable defaults `>` -var or-var-file `>` .autotfvars or .autotfvars.json `>` terraform.tfvars.json `>` terraform.tfvars `>` Environment variables (TF_VAR_variable_name)

### variables.tf file (input variable documentation)
Example:

```h
variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server."
}

variable "availability_zone_names" {
  type    = list(string)
  default = ["eu-west-2"]
}
```

This is the format variables are specified, by name and type. Other options include descriptions and default values to be used if a variable isn't loading in.


### var flag
We can use the `var` flag to set a input variable or override a variable in the tfvars file e.g. `terraform -var user_uuid="my-user_uuid"`.

### var-file flag

To set lots of variables, it is more convenient to specify their values in a variable definitions file (with a filename ending in either .tfvars or .tfvars.json) and then specify that file on the command line with -var-file.
### .tfvars file
A variable definitions file uses the same basic syntax as Terraform language files, but consists only of variable name assignments.

`.auto.tfvars` has higher precedance than terraform.tfvars but acts the same.

`terraform.tfvars` is the defult file to load in many Terraform variables in one go.

### Env Vars
A less prioritised way of defining variables for Terraform, is the use of env vars prefix with `TF_VAR_` then the name of a declared variable.

[Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)