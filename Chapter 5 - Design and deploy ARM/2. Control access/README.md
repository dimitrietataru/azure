# CONTROL ACCESS

### REGISTER AN APPLICATION IN AZURE AD
```powershell
$adAppName="contos0"
$adAppIdUris="https://contos0-app"

$app = New-AzureRmADApplication `
    -DisplayName $adAppName `
    -IdentifierUris $adAppIdUris 
```

```bash
adAppName="contos0"
adAppIdUris="https://contos0-app"

az ad app create \
    --display-name $adAppName \
    --homepage $adAppIdUris \
    --identifier-uris $adAppIdUris
```



### CREATE A SERVICE PRINCIPAL IN AZURE AD
```powershell
$adAppName="contos0"
$adAppIdUris="https://contos0-app"

$app = New-AzureRmADApplication `
    -DisplayName $adAppName `
    -IdentifierUris $adAppIdUris

$sp = New-AzureRmADServicePrincipal `
    -ApplicationId $app.ApplicationId
```

```bash
adAppId="35608b3c-b294-4b74-983a-cfbcba89aeb0"

az ad sp create \
    --id $adAppId
```



### CREATE CUSTOM RESOURCE POLICY
```powershell
$policyName = "denyStorageAccountWithoutEncryption"

$policyDef = New-AzureRmPolicyDefinition `
    -Name $policyName `
    -DisplayName $policyName '
    -Description "Require storage accounts to have the storage encryption service enabled" `
    -Policy ".\denyStorageWithoutEncryption.json" 
```

```bash
policyName = "denyStorageAccountWithoutEncryption"

az policy assignment create \
    --policy $policyName
```



### CREATE A RESOURCE LOCK
```powershell
$lockName = "devGroupNoDeleteLock"
$resourceGroupName = "Dev"

# Create a CanNotDelete resource lock for the resource group (ie: all resources in the resource group)
New-AzureRmResourceLock `
    -LockName $lockName `
    -LockLevel CanNotDelete '
    -ResourceGroupName $resourceGroupName 
```

```bash
# Resource lock properties
lockName="vmNoDeleteLock"
resourceGroupName="Dev"
resourceName="jenkinsVM"
resourceType="Microsoft.Compute/virtualMachines"

# Create a CanNotDelete resource lock for a virtual machine
az lock create \
    --name $lockName \
    --lockType CanNotDelete \
    --resource-group $resourceGroupName \
    --resource-name $resourceName \
    --resource-type $resourceType
```
