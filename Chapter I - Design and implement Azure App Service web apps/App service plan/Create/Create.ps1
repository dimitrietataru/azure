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
	