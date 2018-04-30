# APP SERVICE PLAN

### CREATE
```powershell
$resourceGroupName = "contoso"
$appServicePlanName = "contoso"
$location = "West US"
$tier = "Premium"
$workerSize = "small"

New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $location

New-AzureRmAppServicePlan `
    -ResourceGroupName $resourceGroupName `
    -Name $name `
    -Location  $location `
    -Tier $tier `
    -WorkerSize $workerSize
```

```bash
resourceGroupName = "contoso"
appServicePlanName = "contoso"
location = "westus"
sku = "P1"

az group create \
    --location $location \
    --name $resourceGroupName

az appservice plan create \
    --resource-group $resourceGroupName \
    --name $appServicePlanName \
    --location $location \
    --sku $sku
```
