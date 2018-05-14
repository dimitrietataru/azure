# IMPLEMENT ARM TEMPLATES

### DEPLOY AN ARM TEMPLATE
```powershell
$resourceGroupName = "contoso"
$location = "westus"
$deploymentName = "contoso-deployment-01"

# Create the resource group
$rg = New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $location `
    -Force

# Deploy the ARM template
New-AzureRmResourceGroupDeployment `
    -ResourceGroupName $rg.ResourceGroupName `
    -Name $deploymentName `
    -TemplateFile ".\azuredeploy.json" `
    -TemplateParameterFile ".\azuredeploy.parameters.json" 
```

```bash
resourceGroupName="contoso"
location="westus"
deploymentName = "contoso-deployment-01"

# Create the resource group
az group create \
    --name $resourceGroupName \
    --location $location

# Deploy the ARM template
az group deployment create \
    --resource-group $resourceGroupName \
    --name $deploymentName \
    --template-file "./azuredeploy.json" \
    --parameters "./azuredeploy.parameters.json"
```
