# DEPLOYMENT SLOT

### CREATE
```powershell
$resourceGroupName = "contoso"
$webAppName = "contoso-hr-app"
$stagingSlotName = "Staging"

New-AzureRmWebAppSlot
    -ResourceGroupName $resourceGroupName `
    -Name $name `
    -Slot $stagingSlotName
```

```bash
resourceGroupName = "contoso"
webAppName = "contoso-hr-app"
stagingSlotName = "Staging"

az webapp deployment slot create
    --resource-group $resourceGroupName \
    --name $webAppName \
    --slot $stagingSlotName
```
