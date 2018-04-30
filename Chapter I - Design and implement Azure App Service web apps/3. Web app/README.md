# WEB APP

### GET
```powershell
$resourceGroupName = "contoso"
$webAppName = "contose-hr-app"

$webApp = Get-AzureRmWebApp `
    -ResourceGroupName $resourceGroupName `
    -Name $name
```

```bash
---
```

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

### CONFIGURE APPLICATION SETTINGS
```powershell
$resourceGroupName = "contoso"
$webAppName = "contose-hr-app"
$webApp = Get-AzureRmWebApp `
    -ResourceGroupName $resourceGroupName `
    -Name $name
$settings = $webApp.SiteConfig.AppSettings

$newSettings = New-Object Hashtable
$newSettings["settings1"] = "value-1"
$newSettings["settings2"] = "value-2"
foreach ($setting in $settings) {
    $newSettings.Add($setting.Name, $setting.Value)
}

Set-AzureRmWebApp
    -ResourceGroupName $resourceGroupName `
    -Name $webAppName `
    -AppSettings $newSettings
```

```bash
resourceGroupName = "contoso"
webAppName = "contose-hr-app"

az webapp config appsettings set \
    --resource-group $resourceGroupName \
    --name $webAppName \
    --settings settings3=value-3
```
