# CREATE VIRTUAL MACHINES



### Create simple VM
```bash
vmName="myUbuntuVM"
imageName="UbuntuLTS"
az vm create
    --resource-group $rgName
    --name $vmName
    --image $imageName
    --generate-ssh-keys
```


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

```bash
vnetName="ExamRefVNET-CLI"
vnetAddressPrefix="10.0.0.0/16"
az network vnet create
    --resource-group $rgName
    -n ExamRefVNET-CLI
    --address-prefixes $vnetAddressPrefix
    -l $location
    
Subnet1Name="Subnet-1"
Subnet2Name="Subnet-2"
Subnet1Prefix="10.0.1.0/24"
Subnet2Prefix="10.0.2.0/24"
az network vnet subnet create
    --resource-group $rgName
    --vnet-name $vnetName
    -n $Subnet1Name
    --address-prefix $Subnet1Prefix
az network vnet subnet create
    --resource-group $rgName
    --vnet-name $vnetName
    -n $Subnet2Name
    --address-prefix $Subnet2Prefix
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
storageAccountName="examrefstoragew124124"
az storage account create
    -n $storageAccountName
    --sku Standard_LRS
    -l $location
    --kind Storage
    --resource-group $rgName
```



### Create availability set
```powershell
$avSet = New-AzureRmAvailabilitySet
    -ResourceGroupName $rgName `
    -Name $avSet `
    -Location $location
```

```bash
avSetName="WebAVSET"
az vm availability-set create
    -n $avSetName
    -g $rgName
    --platform-fault-domain-count 3
    --platform-update-domain-count 5
    --unmanaged
    -l $location
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
dnsRecord="examrefdns123123"
ipName="ExamRefCLI-IP"
az network public-ip create
    -n $ipName
    -g $rgName
    --allocation-method Dynamic
    --dns-name $dnsRecord
    -l $location
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
nsgName="webnsg"
az network nsg create
    -n $nsgName 
    -g $rgName 
    -l $location
    
# Create a rule to allow in SSH
az network nsg rule create
    -n SSH
    --nsg-name $nsgName
    --priority 100
    -g $rgName
    --access Allow 
    --description "SSH Access" 
    --direction Inbound 
    --protocol Tcp 
    --destinationaddress-prefix "*" 
    --destination-port-range 22 
    --source-address-prefix "*" 
    --sourceport-range "*"

# Create a rule to allow in HTTP
az network nsg rule create 
    -n HTTP 
    --nsg-name webnsg 
    --priority 101 
    -g $rgName 
    --access Allow 
    --description "Web Access" 
    --direction Inbound 
    --protocol Tcp 
    --destinationaddress-prefix "*" 
    --destination-port-range 80 
    --source-address-prefix "*" 
    --sourceport-range "*"
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
nicname="WebVMNic1"
az network nic create
    -n $nicname 
    -g $rgName 
    --subnet $Subnet1Name 
    --network-securitygroup $nsgName
    --vnet-name $vnetName 
    --public-ip-address $ipName 
    -l $location
```



### VM configure
```powershell
$vmSize = "Standard_DS1_V2"
$vm = New-AzureRmVMConfig
    -VMName $vmName
    -VMSize $vmSize `
    -AvailabilitySetId $avSet.Id
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



### VM provisioning
```powershell
New-AzureRmVM
    -ResourceGroupName $rgName
    -Location $location
    -VM $vm
```

```bash
imageName="Canonical:UbuntuServer:17.04:latest"
vmSize="Standard_DS1_V2"
containerName=vhds
user=demouser
vmName="WebVM"
osDiskName="WEBVM1-OSDISK.vhd"
az vm create
    -n $vmName 
    -g $rgName 
    -l $location 
    --size $vmSize 
    --availability-set $avSetName 
    --nics $nicname 
    --image $imageName 
    --use-unmanaged-disk 
    --os-disk-name $osDiskName 
    --storage-account $storageAccountName 
    --storage-container-name $containerName 
    --generate-ssh-keys
```