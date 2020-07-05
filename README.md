# Labs "Learning Azure. Deploying Azure Kubernetes Service"

This task helps students to understand the basic principles when working with Azure and get general concepts about deploying Kubernetes cluster using Terraforms.

## Getting Started

This instruction will help you deploy a Kubernetes Cluster using a Log Analytics Workspace for Monitoring on Azure.



### Prerequisites

You need to have the following:
1. Have valid credentials for connecting to a cloud provider Azure.
2. Install Terroform on your laptop or virtual machine. 
This instruction will help you if you have not already installed terraform.

https://learn.hashicorp.com/terraform/getting-started/install.html
3. Install Azure CLI
This instruction will help you if you have not already installed one.
https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest

### Installing


1. Clone repository https://github.com/tovmariupol/terraform_azure.git
2. Set the necessary variables to connect to the provider :
	export ARM_SUBSCRIPTION_ID=xxxxxxxxxx
	export ARM_CLIENT_ID=xxxxxxxxxx
	export ARM_CLIENT_SECRET=xxxxxxxxxx
	export ARM_TENANT_ID=xxxxxxxxxx
All variables can be obtained on the portal.
Or if you know subscription ID you can create a service principal with the Azure CLI
	az login
	az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/subscription_ID"
3. Set the necessary variables for Terroform
	export TF_VAR_client_id=${ARM_CLIENT_ID}
	export TF_VAR_client_secret=${ARM_CLIENT_SECRET}
4. Initialize a working directory containing Terraform configuration files
	terraform init
5. Apply Configuration Changes.
	terraform plan -out run.plan
You should set the values for the following variables:
		description
"prefix"   	"A prefix used for all resources in this example"
For example: 	test
"location"  	"The Azure Region in which all resources in this example should be provisioned"
For example:	francecentral
"node_count" 	"The node_count is the number of nodes in the cluster"
For example:	2
"vm_size" 	"The vm_size is the size of the virtual machine in cloud"
For example:	Standard_DS2_v2

6. Deploy a Kubernetes cluster
	terraform apply "run.plan" 


### Checking

To check the installation status, run the following command
	terraform show

Also you can check cluster status through the dashboard Kubernetis.
To access the dashboard Kubernetis you should use portal Azure or execute the following commands Azure CLI.

	az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
	az aks browse --resource-group myResourceGroup --name myAKSCluster

### Destroying Kubernetes Cluster

	terraform destroy

## Versioning
v0.0.1

## Authors
Oleh Tyshchenko



