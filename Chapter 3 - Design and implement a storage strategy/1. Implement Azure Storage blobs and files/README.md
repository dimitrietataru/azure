# IMPLEMENT AZURE STORAGE BLOBS AND FILES

### CREATE CONTAINER
```powershell
$storageAccount = "[storage account name]"
$resourceGroup = "[resource group name]"
$storageKey = Get-AzureRmStorageAccountKey `
    -ResourceGroupName $resourceGroup `
    -StorageAccountName $storageAccount
$context = New-AzureStorageContext `
    -StorageAccountName $storageAccount `
    -StorageAccountKey $storageKey.Value[0]
New-AzureStorageContainer `
    -Context $context `
    -Name "examrefcontainer1" `
    -Permission Off 
```

```bash
storageaccount = "[storage account name]"
containername = "[storage account container]"
az storage container create \
    --account-name $storageaccount \
    --name $containername \
    --public-access off \
```



UPLOAD A FILE
```powershell
$containerName = "[storage account container]"$blobName = "[blob name]"
$localFileDirectory = "C:\SourceFolder"
$localFile = Join-Path $localFileDirectory $BlobName
Set-AzureStorageBlobContent `
    -File $localFile `
    -Container $ContainerName `
    -Blob $blobName `
    -Context $context 
```

```bash
container_name="[storage account container]"
file_to_upload="C:\SourceFolder\[blob name]"
blob_name="[blob name]"
az storage blob upload \
    --container-name $container_name \
    --file $file_to_upload \
    --name $blob_name
```



### CREATE STORAGE ACCOUNT
```powershell
$accountName = "[storage account name]"
$location = "West US"
$type = "Standard_LRS"
New-AzureStorageAccount `
    -StorageAccountName $accountName `
    -Location $location `
    -Type $type
$type = "Standard_RAGRS"
Set-AzureStorageAccount `
    -StorageAccountName $accountName `
    -Type $type
```



### ASYNC BLOB COPY
```powershell
$blobCopyState = Start-AzureStorageBlobCopy `
    -SrcBlob $blobName `
    -SrcContainer $srcContainer `
    -Context $srcContext `
    -DestContainer $destContainer `
    -DestBlob $vhdName `
    -DestContext $destContext
```

```bash
blobName="[file name]"
srcContainer="[source container]"
destContainer="[destination container]"
srcStorageAccount="[source storage]"
destStorageAccount="[destination storage]"
az storage blob copy start \
    --account-name "$destStorageAccount" \
    --account-key "$destStorageKey" \
    --destination-blob "$blobName" \
    --destination-container "$destContainer" \
    --source-account-name "$srcStorageAccount" \
    --source-container "$srcContainer" \
    --source-blob "$blobName" \
    --source-account-key "$srcStorageKey"
```



### CREATE A FILE SHARE
```powershell
$storageAccount = "[storage account]"
$rgName = "[resource group name]"
$shareName = "contosoweb"
$storageKey = Get-AzureRmStorageAccountKey `
    -ResourceGroupName $rgName `
    -Name $storageAccount
$ctx = New-AzureStorageContext `
    -StorageAccountName $storageAccount `
    -StorageAccountKey $storageKey.Value[0]
New-AzureStorageShare `
    -Name $shareName `
    -Context $ctx
```

```bash
rgName="[resource group name]"
storageAccountName="[storage account]"
shareName="contosoweb"
constring=$(az storage account show-connection-string \
    -n $storageAccountName \
    -g $rgName \
    --query 'connectionString' \
    -o tsv)
az storage share create \
    --name $shareName \
    --quota 2048 \
    --connection-string $constring
```
