# CREATE VIRTUAL MACHINES FROM AN ARM TEMPLATE



### Create VM from ARM
# Create a Resource Group
$rgName = "Contoso"
$location = "WestUs"
New-AzureRmResourceGroup
    -Name $rgName
    -Location $location
    
# Deploy a Template from GitHub
$deploymentName = "simpleVMDeployment"
$templateUri = "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json"

New-AzureRmResourceGroupDeployment
    -Name $deploymentName `
    -ResourceGroupName $rgName `
    -TemplateUri $templateUri
```

```bash
# Create the resource group
rgName="Contoso"
location="WestUS"
az group create
    --name $rgName
    --location $location

# Deploy the specified template to the resource group
deploymentName="simpleVMDeployment"
templateUri="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json"
az group deployment create
    --name $deploymentName
    --resource-group $rgName
    --templateuri $templateUri
```
