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

### ENABLE DIAGNOSTIC LOGS
```powershell
$resourceGroupName = "contoso"
$webAppName = "contose-hr-app"
$webApp = Get-AzureRmWebApp `
    -ResourceGroupName $resourceGroupName `
    -Name $name `
    
Set-AzureRmWebApp
    -ResourceGroupName $resourceGroupName `
    -Name $webAppName `
    -RequestTracingEnabled $true `
    -HttpLoggingEnabled $true
```

```bash
resourceGroupName = "contoso"
webAppName = "contose-hr-app"

az webapp log config \
    --resource-group $resourceGroupName \
    --name $webAppName \
    --application-logging true \
    --failed-request-tracing true
```

### RETRIEVE DIAGNOSTIC LOGS
```powershell
$ws-name = "contoso-web"

Save-AzureWebSiteLog `
    -Name $ws-name `
    -Output d:\weblogs.zip
```

```bash
resourceGroupName = "contoso"
webAppName = "contose-web"

az webapp log download \
    --resource-group $resourceGroupName \
    --name $webAppName \
    --log-file ./webapplogs.zip
```
