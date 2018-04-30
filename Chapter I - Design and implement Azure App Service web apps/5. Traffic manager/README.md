# TRAFFIC MANAGER

### CREATE
```powershell
$tmName = "contoso-public"
$tmDnsName = "contoso-public-tm"
$ttl = 300
$monitorProtocol = "TCP"
$monitorPort = 8082

New-AzureRmTrafficManagerProfile `
    -ResourceGroupName $resourceGroupName `
    -Name $name `
    -RelativeDnsName $tmDnsName `
    -Ttl $ttl `
    -TrafficRoutingMethod Performance `
    -MonitorProtocol $monitorProtocol `
    -MonitorPort $monitorPort
```

### ADD ENDPOINTS
```powershell
$resourceGroupName = "contoso"
$webAppName = "contoso-web"
$tmName = "contoso-public"
$newTmEndpointName = "Contoso-Web-1"
$newTmEndpointTarget = "contoso-web.azurewebsites.net"
$tmProfile = Get-AzureRmTrafficManagerProfile `
    -ResourceGroupName $resourceGroupName `
    -Name $tmName
$webApp = Get-AzureRmWebApp `
    -ResourceGroupName $resourceGroupName `
    -Name $webAppName

New-AzureRmTrafficManagerEndpoint
    -ResourceGroupName $resourceGroupName `    
    -ProfileName $tmProfile.Name `
    -Name $newTmEndpointName `
    -Type AzureEndpoints `
    -EndpointStatus Endbled `
    -TargetResourceId $webApp.Id
```

### REMOVE ENDPOINTS
```powershell
$resourceGroupName = "contoso"
$tmProfile = Get-AzureRmTrafficManagerProfile `
    -ResourceGroupName $resourceGroupName `
    -Name $tmName
    
Remove-AzureRmTrafficManagerEndpoint `
    -ResourceGroupName $resourceGroupName `
    -ProfileName $tmProfile.Name `
    -Name $newTmEndpointName `
    -Type AzureEndpoints `
    -Force
```

### DISABLE ENDPOINTS
```powershell
$resourceGroupName = "contoso"
$tmProfile = Get-AzureRmTrafficManagerProfile `
    -ResourceGroupName $resourceGroupName `
    -Name $tmName
    
Disable-AzureRmTrafficManagerEndpoint `
    -ResourceGroupName $resourceGroupName `
    -ProfileName $tmProfile.Name `
    -Name $newTmEndpointName `
    -Type AzureEndpoints `
    -Force
```
