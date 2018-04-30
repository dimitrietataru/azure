# APP SERVICE PLAN

### CREATE
```powershell
# Define properties for the app service plan
$resourceGroupName = "contoso"
$appServicePlanName = "contoso"
$location = "West US"
$tier = "Premium"
$workerSize = "small"

# Create a new resource group
New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $location

# Create a new app service plan
New-AzureRmAppServicePlan `
    -ResourceGroupName $resourceGroupName `
    -Name $name `
    -Location  $location `
    -Tier $tier `
    -WorkerSize $workerSize
```

```cli
# Define properties for the app service plan
resourceGroupName = "contoso"
appServicePlanName = "contoso"
location = "westus"
sku = "P1"

# Create a new resource group
az group create \
    --location $location \
    --name $resourceGroupName

# Create a new app service plan
az appservice plan create \
    --resource-group $resourceGroupName \
    --name $appServicePlanName \
    --location $location \
    --sku $sku
```
