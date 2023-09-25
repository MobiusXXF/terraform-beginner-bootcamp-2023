# Week 1 - Building Terrahouse

## Table of Contents

- [Root Module](#root-module)
- [Variables in Terraform Cloud](#variables-in-terraform-cloud)
- [(IDE...) Loading Terraform Input Variables](#ide-loading-terraform-input-variables)
- [](#variablestf-file-input-variable-documentation)
  - [-var Flag](#var-flag)
  - [-var-file Flag](#var-file-flag)
  - [.tfvars File](#tfvars-file)
  - [Env Vars](#env-vars)
- [Dealing With Configuration Drift](#dealing-with-configuration-drift)
  - [Fix Missing Resources with Terraform Import](#fix-missing-resources-with-terraform-import)
  - [Fix Manual Configuration](#fix-manual-configuration)
- [AWS Terrahouse Module](#aws-terraform-module)
  - [Module Sources](#module-sources)
- [S3 Static Website Hosting](#s3-static-website-hosting)
  - [Working With Files in Terraform](#working-with-files-in-terraform)
  - [Filemd5](#filemd5)
  - [Path Variable](#path-variable)
- [Content Delivery Network Implementation](#content-delivery-network-implementation)
  - []()
  - []()
- []()
  - []()


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


## Dealing With Configuration Drift
Lose of state file may have to be resolved with partial/complete teardown. However, depending on the resources, it can be rectified.

### Fix Missing Resources With Terraform Import
Using `terraform import` we can import provisioned resources that are missing from the `.tfstate` file. By checking the provider documentation, we see what resources `can` be imported and the appropriate command syntax to do so. 

```tf
terraform import aws_s3_bucket.bucket bucket-name
```

You can also do the same by using an import block, like in this example:

```js
import {
  to = aws_s3_bucket.bucket
  id = "bucket-name"
}
```

[Example for Importing S3 Bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration
Resources have the potential to be manually deleted through ClickOps, the use of the AWS Console/GUI.

Here terraform plan does a good job of acknowledging the difference or drift, and attempts to reinstate infrastructure back to expected state.

## Fix Using Terraform "Refresh"
This command reads the current settings from all managed remote objects an updates the Terraform state to match.

```bash
terraform apply -refresh-only --auto-approve
```

## AWS Terrahouse Module
Modules allow for better organisation of infrastructure, into categories such as `storage` or `content delivery`. Where related resources a grouped together and enable reusability of resource configurations with Terraform.

### Module Sources
This part of the module block allows Terraform to know where to source the configuration files for the desired child module, i.e terrahouse_aws:

```js
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
As shown above, input variables can be passed into the module, and these variables need to be declared in its own `variables.tf` file and more simply into the root module.

Using the source we can import the module from various places e.g:
- Locally
- Github
- Terraform Registry


## S3 Static Website Hosting
In this bootcamp we configure with Terraform, meaning provising infrastructure, configuration manangement (`provisioners` - not ideal, `Ansible` more production standard) and data configuration (of files). To learn the capabilities of Terraform.

### Working With Files in Terraform

### Fileexists function
This is a built in terraform function to check the existance of a file.

```condition = fileexists(var.error_html_filepath)```
[https://developer.hashicorp.com/terraform/language/functions/fileexists](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5
This built in function hashes the contents of the file which we use to check content status of a file.

[https://developer.hashicorp.com/terraform/language/functions/filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable
In terraform there is a special variable called path that allows us to reference local paths:

path.module = get the path for the current module
path.root = get the path for the root module 

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

```js
resource "aws_s3_object" "index_html" { 
  bucket = aws_s3_bucket.website_bucket.bucket 
  key = "index.html" 
  source = "${path.root}/public/index.html" }
```
<hr width="75%">

#### Typo Error with S3 bucket configuration:
During the Content Delivery Network lecture I found that the `error.html` file kept being served up as the `default_root_object`, which is set to `index.html`. After some investigation I realised the files had the same etag, so the same file must be duplicated for some reason or being uploaded as the source for both html objects.

Eventually I discovered that I accidently passed the wrong variable into the index_html_filepath:
```js
index_html_filepath = var.error_html_filepath
```
I rectified this by change replacing the `error` with the correct matching variable `index`:
```js
index_html_filepath = var.index_html_filepath
```

**NOTE:** It reminded me to be more careful to avoid typos and how easy it is to miss. Checking the contents of the S3 object in question earlier would have sped up the troubleshooting process.


## Content Delivery Network Implementation
We are using CloudFront as our Content Delivery Network, which provides a globally-distributed network of proxy servers to cache content, e.g. html files and images, more locally to users which reduces latency and improves user experience.

### Terraform Locals
Local variables can be defined uses `locals`. Useful when transforming data to another format and then referencing it as a variable.

```py
locals {
  s3_origin_id = "MyS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources
Data Sources are used to get information from external/internal resources and insert that information into our Terraform Configuration.

[AWS Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

