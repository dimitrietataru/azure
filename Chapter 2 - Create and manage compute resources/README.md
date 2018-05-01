# CHAPTER II

|            ##            | Action               | PowerShell                         | Azure CLI                        |
|:------------------------:|:--------------------:|:-----------------------------------|:---------------------------------|
|      Virtual machine     | Create               | New-AzureRmVirtualMachine          | az vm create                     |
|                          | Configure            | New-AzureRmVMConfig                | ---                              |
|      Virtual network     | Create               | New-AzureRmVirtualNetwork          | az network vnet create           |
|  Virtual network subnet  | Create               | New-AzureRmVirtualNetworkSubnetC.. | az network vnet subnet create    |
|      Storage account     | Get                  | Get-AzureRmStorageAccount          | ---                              |
|                          | Create               | New-AzureRmStorageAccount          | az storate account create        |
|     Availability set     | Create               | New-AzureRmAvailabilitySet         | az vm availability-set create    |
|     Public IP address    | Create               | New-AzureRmPublicIpAddress         | az network public-ip create      |
|  Network security group  | Create               | New-AzureRmNetworkSecurityGroup    | az network nsg create            |
|                          | Rule config          | New-AzureRmNetworkSecurityRuleCo.. | ???            |
|     Network interface    | Create               | New-AzureRmNetworkInterface        | az network nic create            |


|                          | OS create            | New-AzureRmVMOperatingSystem       | ---                              |
|                          | Source image config  | Set-AzureRmVMSourceImage           | az vm image list                 |
|                          | OS disk config       | Set-AzureRmVMOSDisk                | ---                              |
|                          | Desired state config | Set-AzureRmVmDscExtension          | ??                               |
|                          | Custom script        | Set-AzureRmVmCustomScriptExtension | az vm extension set              |








| Virtual machine from ARM | Create               | New-AzureRmResourceGroupDeployment | ??                               |
