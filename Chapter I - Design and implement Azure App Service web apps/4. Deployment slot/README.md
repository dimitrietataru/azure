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

### SWAP
```powershell
$resourceGroupName = "contoso"
$webAppName = "contoso-hr-app"
$stagingSlotName = "Staging"
$productionSlotName = "Production"

Swap-AzureRmWebAppSlot
    -ResourceGroupName $resourceGroupName `
    -Name $name `
    -SourceSlotName $stagingSlotName `
	-DestinationSlotName $productionSlotName
```

```bash
resourceGroupName = "contoso"
webAppName = "contoso-hr-app"
stagingSlotName = "Staging"
productionSlotName = "Production"
swapAction = "swap"

az webapp deployment slot swap
    --resource-group $resourceGroupName \
    --name $webAppName \
    --slot $stagingSlotName \
	--target-slot $productionSlotName \
	--action $swapAction
```
