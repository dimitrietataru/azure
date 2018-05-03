# CONFIGURE VIRTUAL NETWORKS

### CREATE A VIRTUAL NETWORK
```powershell
$subnet1Name = "Apps"
$subnet2Name = "Data"
$subnet1AddressPrefix = "10.0.0.0/24"
$subnet2AddressPrefix = "10.0.1.0/24"
$vnetAddresssSpace = "10.0.0.0/16"
$VNETName = "ExamRefVNET-PS"
$rgName = "ExamRefRGPS"
$location = "Central US"

$subnets = @()
$subnets = New-AzureRmVirtualNetworkSubnetConfig `
    -Name $subnet1Name `
    -AddressPrefix $subnet1AddressPrefix
$subnets = New-AzureRmVirtualNetworkSubnetConfig `
    -Name $subnet2Name `
    -AddressPrefix $subnet2AddressPrefix
    
$vnet = New-AzureRmVirtualNetwork `
    -Name $VNETName `
    -ResourceGroupName $rgName `
    -Location $location `
    -AddressPrefix $vnetAddresssSpace `
    -Subnet $subnets
```

```bash
az group create \
    -n ExamRefRGCLI \
    -l "centralus"
    
az network vnet create \
    --resource-group ExamRefRGCLI \
    -n ExamRefVNET-CLI \
    --address-prefixes 10.0.0.0/16 \
    -l "centralus"

az network vnet subnet create \
    --resource-group ExamRefRGCLI \
    --vnet-name ExamRefVNET-CLI \
    -n Apps \
    --address-prefix 10.0.1.0/24
    
az network vnet subnet create \
    --resource-group ExamRefRGCLI \
    --vnet-name ExamRefVNET-CLI \
    -n Data \
    --address-prefix 10.0.2.0/24
```



### CONFIGURE VNET CUSTOM DNS SETTINGS
```powershell
$subnet1Name = "Apps"
$subnet2Name = "Data"
$subnet1AddressPrefix = "10.0.0.0/24"
$subnet2AddressPrefix = "10.0.1.0/24"
$vnetAddresssSpace = "10.0.0.0/16"
$VNETName = "ExamRefVNET-PS"
$rgName = "ExamRefRGPS"
$location = "Central US"

$subnets = @()
$subnets = New-AzureRmVirtualNetworkSubnetConfig `
    -Name $subnet1Name `
    -AddressPrefix $subnet1AddressPrefix
$subnets = New-AzureRmVirtualNetworkSubnetConfig `
    -Name $subnet2Name `
    -AddressPrefix $subnet2AddressPrefix
    
$vnet = New-AzureRmVirtualNetwork `
    -Name $VNETName `
    -ResourceGroupName $rgName `
    -Location $location `
    -AddressPrefix $vnetAddresssSpace `
    -DNSServer 10.0.0.4,10.0.0.5 `
    -Subnet $subnet 
```

```bash
az network vnet create \
    --resource-group ExamRefRGCLI \
    -n ExamRefVNET-CLI \
    --address-prefixes 10.0.0.0/16 \
    --dns-servers 10.0.0.4 10.0.0.5 \
    -l "centralus"
```



### CREATE A VNET PEERING
```powershell
# Load VNETA and VNETB into Variables
$vneta = Get-AzureRmVirtualNetwork `
    -Name "VNETA" `
    -ResourceGroupName "VNETARG"
    
$vnetb = Get-AzureRmVirtualNetwork `
    -Name "VNETB" `
    -ResourceGroupName "VNETBRG"

# Peer VNETA to VNETB.
Add-AzureRmVirtualNetworkPeering `
    -Name 'VNETA-to-VNETB' `
    -VirtualNetwork $vneta `
    -RemoteVirtualNetworkId $vnetb.Id

# Peer VNETB to VNETA.
Add-AzureRmVirtualNetworkPeering `
    -Name 'VNETA-to-VNETB'
    -VirtualNetwork $vnetb `
    -RemoteVirtualNetworkId $vneta.Id

#Check on the Peering Status
Get-AzureRmVirtualNetworkPeering `
    -ResourceGroupName VNETARG `
    -VirtualNetworkName VNETA `
    | Format-Table VirtualNetworkName, PeeringState
```

```bash
# Get the Resource IDs for VNETA and VNETB.
az network vnet show \
    --resource-group VNETAResourceGroupName \
    --name VNETA \
    --query id \
    --out tsv \
    
az network vnet show \
    --resource-group VNETBResourceGroupName \
    --name VNETB \
    --query id \
    --out tsv
    
# Peer VNETB to VNET
az network vnet peering create \
    --name VNETA-to-VNETB \
    --resource-group VNETARG \
    --vnet-name VNETA \
    --allow-vnet-access \
    --remote-vnet-id /subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/VNETBRG/providers/Microsoft.Network/virtualNetworks/VNETB
    
# Peer VNETB to VNETA
az network vnet peering create \
    --name VNETB-to-VNETA \
    --resource-group VNETBRG \
    --vnet-name VNETB \
    --allow-vnet-access \
    --remote-vnet-id /subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/VNETARG/providers/Microsoft.Network/virtualNetworks/VNETA

# See the Current State of the Peering
az network vnet peering list \
    --resource-group VNETARG \
    --vnet-name VNETA \
    -o table
```



### CREATE A NSG AND ASSOCIATONG WITH A SUBNET
```powershell
# Build a new Inbound Rule to Allow TCP Traffic on Port 80 to the Subnet
$rule1 = New-AzureRmNetworkSecurityRuleConfig `
    –Name PORT_HTTP_80 `
    -Description "Allow HTTP" `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 100 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix 10.0.0.0/24 `
    -DestinationPortRange 80

$nsg = New-AzureRmNetworkSecurityGroup `
    –ResourceGroupName ExamRefRGPS `
    -Location centralus `
    -Name "AppsNSG" `
    -SecurityRules $rule1
    
# Associate the Rule with the Subnet Apps in the Virtual Network ExamRefVNET-PS
$vnet = Get-AzureRmVirtualNetwork `
    –ResourceGroupName ExamRefRGPS `
    –Name ExamRefVNET-PS
    
Set-AzureRmVirtualNetworkSubnetConfig `
    –VirtualNetwork $vnet `
    -Name Apps `
    -AddressPrefix 10.0.0.0/24 `
    -NetworkSecurityGroup $nsg
    
Set-AzureRmVirtualNetwork `
    –VirtualNetwork $vnet
```

```bash
# Create the NSG
az network nsg create \
    --resource-group ExamRefRGCLI \
    --name AppsNSG

# Create the NSG Inbound Rule allowing TCP traffic on Port 80
az network nsg rule create \
    --resource-group ExamRefRGCLI \
    --name PORT_HTTP_80 \
    --nsg-name AppsNSG \
    --direction Inbound \
    --priority 100 \
    --access Allow \
    --source-address-prefix "*" \
    --source-port-range "*" \
    --destination-address-prefix "*" \
    --destination-port-range "80" \
    --description "Allow HTTP" \
    --protocol TCP
    
# Associate the NSG with the ExamRefVNET-CLI Apps Subnet
az network vnet subnet update \
    --resource-group ExamRefRGCLI \
    --vnet-name ExamRefVNET-CLI \
    --name Apps \
    --network-security-group AppsNSG
```



### CREATE AN APP GATEWAY
```powershell
# Create a subnet in the ExamRefVNET-PS VNet with the Address Range of 10.0.98.0/26
$vnet = Get-AzureRmVirtualNetwork `
    -ResourceGroupName ExamRefRGPS `
    -Name ExamRefVNET-PS
    
Add-AzureRmVirtualNetworkSubnetConfig `
    -Name AppGateway `
    -AddressPrefix "10.0.98.0/26" `
    -VirtualNetwork $vnet
    
Set-AzureRmVirtualNetwork `
    -VirtualNetwork $vnet
    
# Create a Public IP address that is used to connect to the application gateway
$publicip = New-AzureRmPublicIpAddress `
    -ResourceGroupName ExamRefRGPS `
    -Name ExamRefAppGW-PubIP `
    -Location "Central US" `
    -AllocationMethod Dynamic
    
# Create a gateway IP configuration
$vnet = Get-AzureRmvirtualNetwork `
    -Name "ExamRefVNET-PS" `
    -ResourceGroupName "ExamRefRGPS"
    
$subnet = Get-AzureRmVirtualNetworkSubnetConfig `
    -Name "AppGateway" `
    -VirtualNetwork $vnet
    
$gipconfig = New-AzureRmApplicationGatewayIPConfiguration `
    -Name "AppGwSubnet01" `
    -Subnet $subnet
    
# Configure a backend pool with the addresses of your web servers
$pool = New-AzureRmApplicationGatewayBackendAddressPool `
    -Name "appGatewayBackendPool"
    
# Configure backend http settings to determine the protocol and port
$poolSetting = New-AzureRmApplicationGatewayBackendHttpSettings `
    -Name "appGatewayBackendHttpSettings" `
    -Port 80 `
    -Protocol Http `
    -CookieBasedAffinity Disabled `
    -RequestTimeout 30
    
# Configure a frontend port that is used to connect to the application gateway through the Public IP address
$fp = New-AzureRmApplicationGatewayFrontendPort `
    -Name frontendport01 `
    -Port 80
    
# Configure the frontend IP configuration with the Public IP address created earlier
$fipconfig = New-AzureRmApplicationGatewayFrontendIPConfig `
    -Name fipconfig01 `
    -PublicIPAddress $publicip
    
# Configure the listener. The listener is a combination of the front-end IP configuration, protocol, and port
$listener = New-AzureRmApplicationGatewayHttpListener `
    -Name listener01 `
    -Protocol Http `
    -FrontendIPConfiguration $fipconfig `
    -FrontendPort $fp

# Configure a basic rule that is used to route traffic to the backend servers
$rule = New-AzureRmApplicationGatewayRequestRoutingRule `
    -Name rule1 `
    -RuleType Basic `
    -BackendHttpSettings
    
$poolSetting `
    -HttpListener $listener `
    -BackendAddressPool $pool
    
# Configure the SKU for the application gateway, this determines the size and WAF usage
$sku = New-AzureRmApplicationGatewaySku `
    -Name "WAF_Medium" `
    -Tier "WAF" `
    -Capacity 2

# Create the application gateway
New-AzureRmApplicationGateway `
    -Name ExamRefAppGWPS `
    -ResourceGroupName ExamRefRGPS `
    -Location "Central US" `
    -BackendAddressPools $pool `
    -BackendHttpSettingsCollection $poolSetting `
    -FrontendIpConfigurations $fipconfig `
    -GatewayIpConfigurations $gipconfig `
    -FrontendPorts $fp `
    -HttpListeners $listener `
    -RequestRoutingRules $rule `
    -Sku $sku `
    -WebApplicationFirewallConfiguration
    
# Set WAF Configuration to Enabled
$AppGw = Get-AzureRmApplicationGateway `
    -Name ExamRefAppGWPS `
    -ResourceGroupName ExamRefRGPS
    
Set-AzureRmApplicationGatewayWebApplicationFirewallConfiguration `
    -ApplicationGateway $AppGw `
    -Enabled $True `
    -FirewallMode "Detection" `
    -RuleSetType "OWASP" `
    -RuleSetVersion "3.0"
```

```bash
# Create a subnet for the App Gateway in the ExamRefVNET-CLI VNet with the Address Range of 10.0.98.0/26
az network vnet subnet create \
    -g ExamRefRGCLI \
    --vnet-name ExamRefVNET-CLI \
    -n AppGateway \
    --address-prefix 10.0.98.0/26
    
# Create a Public IP address that is used to connect to the application gateway.
az network public-ip create \
    -g ExamRefRGCLI \
    -n ExamRefAppGW-PubIP
    
# Create the App gateway named ExamRefAppGWCLI
az network application-gateway create \
    -n "ExamRefAppGWCLI" \
    -g "ExamRefRGCLI" \
    --vnet-name "ExamRefVNET-CLI" \
    --subnet "AppGateway" \
    --capacity 2 \
    --sku WAF_Medium \
    --http-settings-cookie-based-affinity Disabled \
    --http-settings-protocol Http \
    --frontend-port 80 \
    --routing-rule-type Basic \
    --http-settings-port 80 \
    --public-ip-address "ExamRefAppGW-PubIP"

# Enable the WAF
az network application-gateway waf-config set \
    -g "ExamRefRGCLI" \
    -n "ExamRefAppGWCLI" \
    --enabled true \
    --rule-set-type OWASP \
    --rule-set-version 3.0
```

