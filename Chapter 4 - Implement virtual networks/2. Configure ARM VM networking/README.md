# CONFIGURE ARM VM NETWORKING

### ENABLE STATIC PRIVATE IP ADDRESSES ON VMS
```powershell
# Update existing NIC to use a Static IP Address and set the IP
$nic = Get-AzureRmNetworkInterface `
    -Name examrefwebvm1892 `
    -ResourceGroupName ExamRefRGPS
$nic.IpConfigurations[0].PrivateIpAllocationMethod = "Static"
$nic.IpConfigurations[0].PrivateIpAddress = "10.0.0.5"

Set-AzureRmNetworkInterface `
    -NetworkInterface $nic
```

```bash
# Update existing NIC to use a Static IP Address and set the IP
az network nic ip-config update \
    --name ipconfig1 \
    --nic-name examrefwebvm1400 \
    --resourcegroup ExamRefRGCLI \
    --private-ip-address 10.0.1.5
```



### CREATE A PUBLIC IP ADDRESS
```powershell
$publicIpName = "ExamRef-PublicIP1-PS"
$rgName = "ExamRefRGPS"
$dnsPrefix = "examrefpubip1ps"
$location = "centralus"

New-AzureRmPublicIpAddress `
    -Name $publicIpName `
    -ResourceGroupName $rgName `
    -AllocationMethod Static `
    -DomainNameLabel $dnsPrefix `
    -Location $location
```

```bash
az network public-ip create \
    -g ExamRefRGCLI \
    -n ExamRef-PublicIP1-CLI \
    --dns-name examrefpubip1cli \
    --allocation-method Static
```



### CONFIGURE DNS SETTINGS ON NETWORK INTERFACES
```powershell
$nic = Get-AzureRmNetworkInterface `
    -ResourceGroupName "ExamRefRG" `
    -Name "examrefwebvm172"
$nic.DnsSettings.DnsServers.Clear()
$nic.DnsSettings.DnsServers.Add("8.8.8.8")
$nic.DnsSettings.DnsServers.Add("4.2.2.1")
$nic | Set-AzureRmNetworkInterface
```

```bash
az network nic update \
    -g ExamRefRG \
    -n examrefwebvm172 \
    --dns-servers ""

az network nic update \
    -g ExamRefRG \
    -n examrefwebvm172 \
    --dns-servers 8.8.8.8 4.2.2.1
```



### CREATE A NSG AND ASSOCIATE WITH A SUBNET
```powershell
#Build a new Inbound Rule to Allow TCP Traffic on Port 80 to the Subnet
$rule1 = New-AzureRmNetworkSecurityRuleConfig `
    -Name PORT_HTTP_80 `
    -Description "Allow HTTP" `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 100 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix 10.0.0.0/24 `
    -DestinationPortRange 80
    
#Create a new Network Security Group and add the HTTP Rule
$nsg = New-AzureRmNetworkSecurityGroup `
    -ResourceGroupName ExamRefRGPS `
    -Location centralus `
    -Name "ExamRefWEBVM1-nsg" `
    -SecurityRules $rule1
    
#Associate the Rule with the NIC from ExamRefWEBVM1
$nic = Get-AzureRmNetworkInterface `
    -ResourceGroupName ExamRefRGPS `
    -Name examrefwebvm1892
$nic.NetworkSecurityGroup = $nsg

Set-AzureRmNetworkInterface `
    -NetworkInterface $nic
```

```bash
# Create the NSG
az network nsg create \
    --resource-group ExamRefRGCLI \
    --name ExamRefWEBVM1-nsg

# Create the NSG Inbound Rule allowing TCP traffic on Port 80
az network nsg rule create \
    --resource-group ExamRefRGCLI \
    --name PORT_HTTP_80 \
    --nsg-name ExamRefWEBVM1-nsg \
    --direction Inbound \
    --priority 100 \
    --access Allow
    --source-address-prefix "*" \
    --source-port-range "*" \
    --destination-address-prefix "*" \
    --destination-port-range "80" \
    --description "Allow HTTP" \
    --protocol TCP

# Associate the NSG with the NIC from ExamRefWEBVM1
az network nic update \
    --resource-group ExamRefRGCLI \
    --name examrefwebvm1400 \
    --network-security-group ExamRefWEBVM1-nsg
```



### CREATE THE AZURE LOAD BALANCER
```powershell
$publicIpName = "ExamRefLB-PublicIP-PS"
$rgName = "ExamRefRGPS"
$dnsPrefix = "examreflbps"
$location = "centralus"
$lbname = "ExamRefLBPS"
$vnetName = "ExamRefVNET-PS"

# Create the Public IP
$publicIP = New-AzureRmPublicIpAddress `
    -Name $publicIpName `
    -ResourceGroupName $rgName `
    -AllocationMethod Static `
    -DomainNameLabel $dnsPrefix `
    -Location $location
    
#Create Frontend IP Configuration
$frontendIP = New-AzureRmLoadBalancerFrontendIpConfig `
    -Name ExamRefFrontEndPS `
    -PublicIpAddress $publicIP
    
# Create Backend Pool
$beAddressPool = New-AzureRmLoadBalancerBackendAddressPoolConfig `
    -Name ExamRefBackEndPoolPS
    
#Create HTTP Probe
$healthProbe = New-AzureRmLoadBalancerProbeConfig `
    -Name HealthProbe `
    -RequestPath '/' `
    -Protocol http `
    -Port 80 `
    -IntervalInSeconds 5 `
    -ProbeCount 2

#Create Load Balancer Rule
$lbrule = New-AzureRmLoadBalancerRuleConfig `
    -Name ExamRefRuleHTTPPS `
    -FrontendIpConfiguration $frontendIP `
    -BackendAddressPool $beAddressPool `
    -Probe $healthProbe `
    -Protocol Tcp `
    -FrontendPort 80 `
    -BackendPort 80

#Create Load Balancer
New-AzureRmLoadBalancer `
    -ResourceGroupName $rgName `
    -Name $lbName `
    -Location $location `
    -FrontendIpConfiguration $frontendIP `
    -LoadBalancingRule $lbrule `
    -BackendAddressPool $beAddressPool `
    -Probe $healthProbe

# Add the Web Servers to the Backend Pool
$vnet = Get-AzureRmVirtualNetwork `
    -Name $vnetName `
    -ResourceGroupName $rgName
    
$subnet = Get-AzureRmVirtualNetworkSubnetConfig `
    -Name Apps `
    -VirtualNetwork $vnet

$nic1 = Get-AzureRmNetworkInterface `
    -Name examrefwebvm1480 `
    -ResourceGroupName $rgName
$nic1 | Set-AzureRmNetworkInterfaceIpConfig `
    -Name ipconfig1 `
    -LoadBalancerBackendAddressPool $beAddressPool `
    -Subnet $subnet
$nic1 | Set-AzureRmNetworkInterface

$nic2 = Get-AzureRmNetworkInterface `
    -Name examrefwebvm2217 `
    -ResourceGroupName $rgName
$nic2 | Set-AzureRmNetworkInterfaceIpConfig `
    -Name ipconfig1 `
    -LoadBalancerBackendAddressPool $beAddressPool `
    -Subnet $subnet
$nic2 | Set-AzureRmNetworkInterface
```

```bash
# Creating a Public IP Address
az network public-ip create \
    -g ExamRefRGCLI \
    -n ExamRefLB-PublicIP-CLI \
    --dns-name examreflbcli \
    --allocation-method Static

# Create Load Balancer
az network lb create \
    -n ExamRefLBCLI \
    -g ExamRefRGCLI \
    -l centralus \
    --backend-pool-name ExamRefBackEndPoolCLI \
    --frontend-ip-name ExamRefFrontEndCLI \
    --public-ip-address ExamRefLB-PublicIP-CLI

# Create HTTP Probe
az network lb probe create \
    -n HealthProbe \
    -g ExamRefRGCLI \
    --lb-name ExamRefLBCLI \
    --protocol http \
    --port 80 \
    --path / \
    --interval 5 \
    --threshold 2
    
# Create Load Balancer Rule
az network lb rule create \
    -n ExamRefRuleHTTPCLI \
    -g ExamRefRGCLI \
    --lb-name ExamRefLBCLI \
    --protocol Tcp \
    --frontend-port 80 \
    --backend-port 80
    --frontend-ip-name ExamRefFrontEndCLI \
    --backend-pool-name ExamRefBackEndPoolCLI \
    --probe-name HealthProbe

# Add the Web Servers to the Backend Pool
az network nic ip-config address-pool add \
    --address-pool ExamRefBackEndPoolCLI \
    --lb-name ExamRefLBCLI \
    -g ExamRefRGCLI \
    --nic-name examrefwebvm160 \
    --ip-config-name ipconfig1

az network nic ip-config address-pool add \
    --address-pool ExamRefBackEndPoolCLI \
    --lb-name ExamRefLBCLI \
    -g ExamRefRGCLI \
    --nic-name examrefwebvm2139 \
    --ip-config-name ipconfig1
```



### CONFIGURE VMS AS BACKED POOL FOR APP GATEWAY
```powershell
# Add VM IP Addresses to the Backend Pool of App Gateway
$appGw = Get-AzureRmApplicationGateway `
    -Name "ExamRefAppGWPS" `
    -ResourceGroupName "ExamRefRGPS"
$backendPool = Get-AzureRmApplicationGatewayBackendAddressPool `
    -Name "appGatewayBackendPool" `
    -ApplicationGateway $AppGw
$nic01 = Get-AzureRmNetworkInterface `
    -Name "examrefwebvm1480" `
    -ResourceGroupName "ExamRefRGPS"
$nic02 = Get-AzureRmNetworkInterface `
    -Name "examrefwebvm2217" `
    -ResourceGroupName "ExamRefRGPS"

Set-AzureRmApplicationGatewayBackendAddressPool `
    -ApplicationGateway $appGw `
    -Name $backendPool `
    -BackendIPAddresses $nic01.IpConfigurations[0].PrivateIpAddress, `
                        $nic02.IpConfigurations[0].PrivateIpAddress
```

```bash
# Add VM IP Addresses to the Backend Pool of App Gateway
az network application-gateway address-pool update \
    -n appGatewayBackendPool \
    --gateway-name ExamRefAppGWCLI \
    -g ExamRefRGCLI \
    --servers 10.0.0.6 10.0.0.7 
```
