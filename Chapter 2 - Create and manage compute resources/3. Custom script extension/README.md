# CUSTOM SCRIPT EXTENSION



### Using the custom script extension
```powershell
#deployad.ps1
param($domain,$password)
$smPassword = (ConvertTo-SecureString $password -AsPlainText -Force)
Install-WindowsFeature
    -Name "AD-Domain-Services" `
    -IncludeManagementTools `
    -IncludeAllSubFeature
Install-ADDSForest
    -DomainName $domain `
    -DomainMode Win2012 `
    -ForestMode Win2012 `
    -Force `
    -SafeModeAdministratorPassword $smPassword

$rgName = "Contoso"
$scriptName = "deploy-ad.ps1"
$scriptUri = http://$storageAccount.blob.core.windows.net/scripts/$scriptName
$scriptArgument = "contoso.com $password"
Set-AzureRmVMCustomScriptExtension
    -ResourceGroupName $rgName `
    -VMName $vmName `
    -FileUri $scriptUri `
    -Argument "$domain
```

```bash
#install-apache.sh
apt-get update
apt-get -y install apache2 php7.0 libapache2-mod-php7.0
apt-get -y install php-mysql
sudo a2enmod php7.0
apachectl restart

rgName="Contoso"
vmName="LinuxWebServer"
az vm extension set
    --resource-group $rgName 
    --vm-name $vmName 
    --name $scriptName
    --publisher Microsoft.Azure.Extensions 
    --settings ./cseconfig.json
```


