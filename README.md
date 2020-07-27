# Terraform 101 

This repo and class wee will explore terraform, a tool from Hashicorp. Terraform comes from the latin of ' Terra ' which means earth and 'forma' which means form/change.

The naming convention is because the tool is used to orchestrate our infrastructure and is part of IAC (infrastructure as code)

IAC:
* Configuration Management tools
* Orchestration tools

#### Configuration Management tools
Tools include: Chef, puppet, and Ansible
--> Helps us to create imutable infrastructure
If we SSH into our testing server and install `sudo apt-get install type-script`
Now we need to do this all over again on our other machines

If we have something, liek a play or some type of config management tool, then we can mae this change more imtuable and it will be easier to replicate everywhere.

The idea is you should be able to terminate a machine, run a script and end up exactly at the same location/state as the previous machine.

**A tool that helps you do this is a config management tool.**
--> end game should be an AMI of some sort.

#### Orchestration tools
Terraform, cloudform and others.

This will create the infrastructure, not only the specific machine, but the networking, security, monitoring and all the setup around the machine, that creates a production environment

**Example Usage:**
1) Automation server gets triggered
2) Tests are run in machine created from AMI (configuration)
3) Passing tests trigger next step on automation server
4) New AMI is created with previous AMI + new code
5) Successful creation triggers next step in automation server
6) Calls terraform script to create intrastructure and deploy new AMI (with new Code)

**Example usage 2:**
1) Terra form creates VPC
2) Creates two subnets
3) adds rules and security
4) deploys AMIs and runs scripts


The conjunction of the two, allows us to define our infrastructure as code.

Along with version control - such as git - it allows us to maintain and maniupulate infrastructure in ways that were not possible before.

### Terraform terminology & commands

#### terminology
* Providers
* resources:
	* ec2
* variables	

#### commands

* `terraform init`
* `terraform plan`
* `terraform apply`
* `terraform destroy`
