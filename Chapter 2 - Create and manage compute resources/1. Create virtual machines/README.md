# CREATE VIRTUAL MACHINES

### Create resource group
```powershell
$rgName = "Contoso"
$location = "West US"

New-AzureRmResourceGroup
    -Name $rgName
    -Location $location
```

```bash
rgName="Contoso"
location="WestUS"
az group create
	--name $rgName
	--location $location
```

### Create virtual networks
```powershell
$subnet1Name = "Subnet-1"
$subnet2Name = "Subnet-2"
$subnet1AddressPrefix = "10.0.0.0/24"
$subnet2AddressPrefix = "10.0.1.0/24"
$vnetAddresssSpace = "10.0.0.0/16"
$VNETName = "ExamRefVNET-PS"

$subnets = @()
$subnets += New-AzureRmVirtualNetworkSubnetConfig 
    -Name $subnet1Name `
    -AddressPrefix $subnet1AddressPrefix
$subnets += New-AzureRmVirtualNetworkSubnetConfig
    -Name $subnet2Name `
    -AddressPrefix $subnet2AddressPrefix

$vnet = New-AzureRmVirtualNetwork -Name $VNETName `
    -ResourceGroupName $rgName `
    -Location $location `
    -AddressPrefix $vnetAddresssSpace `
    -Subnet $subnets
```

### Create storage account
```powershell
$saName = "examrefstoragew123123"
$storageAcc = New-AzureRmStorageAccount
	-ResourceGroupName $rgName `
	-Name $saName `
	-Location $location `
	-SkuName Standard_LRS
$blobEndpoint = $storageAcc.PrimaryEndpoints.Blob.ToString()
```

```bash

```

### Create availability set
```powershell
$avSet = New-AzureRmAvailabilitySet
	-ResourceGroupName $rgName `
	-Name $avSet `
	-Location $location
```

```bash

```

### Create public IP address
```powershell
$pip = New-AzureRmPublicIpAddress
	-Name $ipName `
	-ResourceGroupName $rgName `
	-Location $location `
	-AllocationMethod Dynamic `
	-DomainNameLabel $dnsName
```

```bash

```

### Create network security group
```powershell
$nsgName = "ExamRefNSG"
$nsgRules = @()
$nsgRules += New-AzureRmNetworkSecurityRuleConfig
	-Name "RDP" `
	-Description "RemoteDesktop" `
	-Protocol Tcp `
	-SourcePortRange "*" `
	-DestinationPortRange "3389" `
	-SourceAddressPrefix "*" `
	-DestinationAddressPrefix "*" `
	-Access Allow `
	-Priority 110 `
	-Direction Inbound
$nsg = New-AzureRmNetworkSecurityGroup
	-ResourceGroupName $rgName `
	-Name $nsgName `
	-SecurityRules $nsgRules `
	-Location $location
```

```bash

```


### Create network interface
```powershell
$nicName = "ExamRefVM-NIC"
$nic = New-AzureRmNetworkInterface
	-Name $nicName `
	-ResourceGroupName $rgName `
	-Location $location `
	-SubnetId $vnet.Subnets[0].Id `
	-PublicIpAddressId $pip.Id `
	-NetworkSecurityGroupId $nsg.ID
```

```bash

```


### VM configure
```powershell
$vmSize = "Standard_DS1_V2"
$vm = New-AzureRmVMConfig
	-VMName $vmName
	-VMSize $vmSize `
	-AvailabilitySetId $avSet.Id
```

```bash

```


### VM Operating system
```powershell
$cred = Get-Credential
Set-AzureRmVMOperatingSystem 
	-Windows `
	-ComputerName $vmName `
	-Credential $cred `
	-ProvisionVMAgent `
	-VM $vm
```

```bash

```

### VM source image
```powershell
$pubName = "MicrosoftWindowsServer"
$offerName = "WindowsServer"
$skuName = "2016-Datacenter"
Set-AzureRmVMSourceImage
	-PublisherName $pubName `
	-Offer $offerName `
	-Skus $skuName `
	-Version

$osDiskName = "ExamRefVM-osdisk"
$osDiskUri = $blobEndpoint + "vhds/" + $osDiskName + ".vhd"
Set-AzureRmVMOSDisk 
	-Name $osDiskName `
	-VhdUri $osDiskUri `
	-CreateOption fromImage `
	-VM $vm
```

```bash

```

### VM provisioning
```powershell
New-AzureRmVM
	-ResourceGroupName $rgName
	-Location $location
	-VM $vm
```

```bash

```