# WEB APP

### CREATE
```powershell
# Define properties for the app service plan
$resourceGroupName = "contoso"
$appServicePlanName = "contoso"
$location = "West US"
$webAppName = "contose-hr-app"

# Create a new web app using an existing app service plan
New-AzureRmWebApp
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -AppServicePlan $appServicePlanName `
    -Name $webAppName
```

```bash
# Define properties for the app service plan
resourceGroupName = "contoso"
appServicePlanName = "contoso"
webAppName = "contose-hr-app"

# Create a new web app using an existing app service plan
az webapp create \
    --resource-group $resourceGroupName \
    --name $webAppName \
    --plan #appServicePlanName
```
