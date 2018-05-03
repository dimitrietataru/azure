# MANAGE ACCESS

### CREATE AN AZURE KEY VAULT. SECURELY STORE THE KEY
```powershell
$vaultName = "[key vault name]"
$rgName = "[resource group name]"
$location = "[location]"
$keyName = "[key name]"
$secretName = "[secret name]"
$storageAccount = "[storage account]"

# Create the key vault
New-AzureRmKeyVault `
    -VaultName $vaultName `
    -ResourceGroupName $rgName `
    -Location $location

# Create a software managed key
$key = Add-AzureKeyVaultKey `
    -VaultName $vaultName `
    -Name $keyName `
    -Destination 'Software'
    
# Retrieve the storage account key
$storageKey = Get-AzureRmStorageAccountKey `
    -ResourceGroupName $rgName `
    -Name $storageAccount
    
# Convert the secret to a secure string
$secretvalue = ConvertTo-SecureString $storageKey[0].Value `
    -AsPlainText `
    -Force

# Set the secret value
$secret = Set-AzureKeyVaultSecret `
    -VaultName $vaultName `
    -Name $secretName `
    -SecretValue $secretvalue
```

```bash
vaultName="[key vault name]"
rgName="[resource group name]"
location="[location]"
keyName="[key name]"
secretName="[secret name]"
storageAccount="[storage account]"
secretValue="[storage account key]"

# Create the key vault
azure keyvault create \
    --vault-name "$vaultName" \
    --resource-group "$rgName" \
    --location "$location"

 # Create a software managed key
azure keyvault key create \
    --vault-name "$vaultName" \
    --key-name $keyName \
    --destination software

 # Set the secret value
azure keyvault secret set \
    --vault-name "$vaultName" \
    --secret-name "$secretName" \
    --value "$secretValue"
```



### CREATING A SHARED ACCESS SIGNATURE
```powershell
$storageAccount = "[storage account]"
$rgName = "[resource group name]"
$container = "[storage container name]"
$startTime = Get-Date
$endTime = $startTime.AddHours(4)
$storageKey = Get-AzureRmStorageAccountKey `
    -ResourceGroupName $rgName `
    -Name $storageAccount
$context = New-AzureStorageContext `
    -StorageAccountName $storageAccount `
    -StorageAccountKey $storageKey[0].Value

New-AzureStorageBlobSASToken `
    -Container $container `
    -Blob "Workshop List - 2017.xlsx" `
    -Permission "rwd" `
    -StartTime $startTime `
    -ExpiryTime $endTime `
    -Context $context 
```

```bash
storageAccount="[storage account name]"
container="[storage container name]"
storageAccountKey="[storage account key]"
blobName="[blob name]"

az storage blob generate-sas \
    --account-name "$storageAccount" \
    --account-key "$storageAccountKey" \
    --container-name "$container" \
    --name "$blobName" \
    --permissions r \
    --expiry "2018-05-31"
```
