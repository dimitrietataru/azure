# IMPLEMENT RECOVERY SERVICES

### CREATE A RECOVERY SERVICES VAULT
```powershell
New-AzureRmResourceGroup `
    -Name 'RSVaultRG' `
    -Location 'South Central US'

New-AzureRmRecoveryServicesVault `
    -Name 'MyRSVault' `
    -ResourceGroupName 'RSVaultRG' `
    -Location 'South Central US'
```



### CREATE A SNAPSHOT
```powershell
$sourceVHDURI = https://criticalserverrgdisks810.blob.core.windows.net/vhds/CriticalServer20171005195926.vhd
$storageAccountId = "/subscriptions/<SubscriptionID>/resourceGroups/criticalserverrg/providers/Microsoft.Storage/storageAccounts/criticalserverrgdisks810"

$snapshotConfig = New-AzureRmSnapshotConfig `
    -AccountType StandardLRS `
    -Location westus2 `
    -CreateOption Import `
    -StorageAccountId $storageAccountId `
    -SourceUri $sourceVHDURI

New-AzureRmSnapshot `
    -Snapshot $snapshotConfig `
    -ResourceGroupName CriticalServerRG `
    -SnapshotName MyCriticalServerDiskSnapshot
```



### COPY THE STORAGE KEY FROM THE DESTINATION STORAGE ACCOUNT
```powershell
$storageAccountKey = "<StorageAccountKey>"
$resourceGroupName ="CriticalServerRG"
$snapshotName = "MyCriticalServerDiskSnapshot"
$sasExpiryDuration = "3600"

$sas = Grant-AzureRmSnapshotAccess `
    -ResourceGroupName $resourceGroupName `
    -SnapshotName $SnapshotName `
    -DurationInSecond $sasExpiryDuration `
    -Access Read

$destinationContext = New-AzureStorageContext `
    –StorageAccountName $storageAcct.StorageAccountName `
    -StorageAccountKey $storageAccountKey

Start-AzureStorageBlobCopy `
    -AbsoluteUri $sas.AccessSAS `
    -DestContainer "recovery" `
    -DestContext $destinationContext `
    -DestBlob "recoveredcriticalserveros.vhd"
```
