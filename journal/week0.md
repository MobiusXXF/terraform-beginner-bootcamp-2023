# Week 0
<ins>Table of Contents</ins>
- [Semantic Versioning](#semantic-versioning)
- []()
- []()


## Semantic Versioning

This project is utilising semantic versioning for its tagging. [semver.org](https://semver.org/)

For example:

**MAJOR.MINOR.PATCH**, e.g. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instrcutions have changed due to gpg keyring changes. So we need to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Checking Linux Version

This project is built against Ubuntu.
Be aware of Linux Distribution and make adjustments accordingly.
To check Linux Version:
```bash
cat /etc/os-release
```
[How to Check OS Version](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)





### Refactoring into Bash Scripts
While fixing the terraform CLI gpg deprecation issues we notice that bash script steps were a considerable amount more code. So we decided to create a [bash script](.bin/install_terraform_cli) to install the Terraform CLI.

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allows us an easier to debug and execute manually Terraform CLI install.
- This will allow better portability for other projects that need to install Terraform CLI.

#### Shebang

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpret the script.

```bash
#!/usr/bin/env bash
```

[More on Shebang](https://en.wikipedia.org/wiki/Shebang_(Unix))

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notation to execute the bash script.

e.g. `./bin/install_terraform_cli`

If we are using the scropt in .gitpod.yml we need to point the script to a program to interpret it.

e.g. `source ./bin/install_terraform_cli`

#### Linux Permissions

In order to change the permissions of a file, i.e `executable`` for a bash script, we must use chmod to change the mode.
```bash
chmod u+x ./bin/install_terraform_cli
```
or:
```bash
chmod 744 ./bin/install_terraform_cli
```

[Linux Permissions](https://en.wikipedia.org/wiki/chmod)

### Github Lifecycle

Need to be careful when using the Init because it will rerun if we restart an exisiting workspace.

[Gitpod Tasks](https://www.gitpod.io/docs/configure/workspaces/tasks)