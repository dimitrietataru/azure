# MANAGE DATA PROTECTION AND SECURITY COMPLIANCE

### CREATE A KEY VAULT
```powershell
$rg = New-AzureRmResourceGroup `
    -Name "MyKeyVaultRG" `
    -Location "South Central US"

New-AzureRmKeyVault `
    -VaultName "MyKeyVault-0" `
    -ResourceGroupName $rg.ResourceGroupName `
    -Location "South Central US"
```

```bash
az group create \
    --name "MyKeyVaultRG" \
    --location "South Central US"
    
az keyvault create \
    --name "MyKeyVault-0" \
    --resource-group "MyKeyVaultRG" \
    --location "South Central US"
```



### CREATE A KEY
```powershell
Add-AzureKeyVaultKey `
    -VaultName "MyKeyVault-001" `
    -Name "MyFirstKey" `
    -Destination "Software"
```

```bash
az keyvault key create \
    --vault-name ‘MyKeyVault-001’ \
    --name ‘MyThirdKey’ \
    --protection ‘software’
```



### ADD A SECRET
```powershell
$mySecret = ConvertTo-SecureString `
    -String ‘P@ssword1233’ `
    -Force -AsPlainText Set-AzureKeyVaultSecret `
    -VaultName ‘MyKeyVault-001’ `
    -Name ‘MyFirstSecret’ `
    -SecretValue $mySecret "Software"
```

```bash
az keyvault secret set \
    --vault-name ‘MyKeyVault-001’ \
    --name ‘MySecondSecret’ \
    --value ‘P@ssword321’
```



### IMPORT CERTIFICATES
```powershell
$CertPwd = ConvertTo-SecureString `
    -String "demo@pass123" `
    -Force `
    -AsPlainText

Import-AzureKeyVaultCertificate `
    -VaultName ‘MyKeyVault-001’ `
    -Name ‘MyFirstCert’ `
    -FilePath ‘C:\ssh\MyCert.pfx’ `
    -Password $CertPwd
```



### CREATE CERTIFICATES
```powershell
$Policy = New-AzureKeyVaultCertificatePolicy `
    -SecretContentType "application/xpkcs12" `
    -SubjectN ame "CN=steverlabs.com" `
    -IssuerName "Self" `
    -ValidityInMonths 6 `
    -ReuseKeyOnRenewal
    
Add-AzureKeyVaultCertificate `
    -VaultName ‘MyKeyVault-001’ `
    -Name "TestCert01" `
    -CertificatePolicy $ Policy
```
