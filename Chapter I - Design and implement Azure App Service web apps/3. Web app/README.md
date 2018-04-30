# WEB APP

### CREATE
```powershell
$resourceGroupName = "contoso"
$appServicePlanName = "contoso"
$location = "West US"
$webAppName = "contose-hr-app"

New-AzureRmWebApp
    -ResourceGroupName $resourceGroupName `
    -Location $location `
    -AppServicePlan $appServicePlanName `
    -Name $webAppName
```

```bash
resourceGroupName = "contoso"
appServicePlanName = "contoso"
webAppName = "contose-hr-app"

az webapp create \
    --resource-group $resourceGroupName \
    --name $webAppName \
    --plan $appServicePlanName
```
