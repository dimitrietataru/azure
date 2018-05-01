# MANAGE ARM VM AVAILABILITY



### Create an availability set
```powershell
$rgName = "ExamRefRG"
$avSetName = "WebAVSet"
$location = "West US"
New-AzureRmAvailabilitySet `
    -ResourceGroupName $rgName `
    -Name $avSetName `
    -Location $location `
    -PlatformUpdateDomainCount 10 `
    -PlatformFaultDomainCount 3 `
    -Sku "Aligned"
```

```bash
rgName="ExamRefRGCLI"
avSetName="WebAVSet"
location="WestUS"
az vm availability-set create \
    --name $avSetName \
    --resource-group $rgName \
    --platformfault-domain-count 3 \
    --platform-update-domain-count 10
```
