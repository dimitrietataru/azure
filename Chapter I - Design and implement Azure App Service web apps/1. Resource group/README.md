# RESOURCE GROUP

### CREATE
```powershell
$resourceGroupName = "contoso"
$location = "West US"

New-AzureRmResourceGroup `
    -Name $resourceGroupName `
    -Location $location
```

```bash
resourceGroupName = "contoso"
location = "westus"

az group create \
    --location $location \
    --name $resourceGroupName
```
