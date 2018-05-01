# CHAPTER II

|            ##            | Action               | PowerShell                         | Azure CLI                        |
|:------------------------:|:--------------------:|:-----------------------------------|:---------------------------------|
|      Virtual machine     | Create               | New-AzureRmVirtualMachine          | az vm create                     |
|                          | Create from ARM      | New-AzureRmResourceGroupDeployment | az group deployment create       |
|                          | Configure            | New-AzureRmVMConfig                | ---                              |
|                          | Operating system     | New-AzureRmVMOperatingSystem       | ---                              |
|                          | OS disk config       | Set-AzureRmVMOSDisk                | ---                              |
|                          | Source image         | Set-AzureRmVMSourceImage           | az vm image list                 |
|                          | Stop                 | Stop-AzureRmVM                     | az vm dealocate                  |
|       Advanced VM        | Custom script        | Set-AzureRmVmCustomScriptExtension | az vm extension set              |
|      Virtual network     | Create               | New-AzureRmVirtualNetwork          | az network vnet create           |
|                          | Create subnet        | New-AzureRmVirtualNetworkSubnetC.. | az network vnet subnet create    |
|                          | Create public IP     | New-AzureRmPublicIpAddress         | az network public-ip create      |
|                          | Create NSG           | New-AzureRmNetworkSecurityGroup    | az network nsg create            |
|                          | Create NSG rule      | New-AzureRmNetworkSecurityRuleCo.. | az network nsg rule create       |
|     Network interface    | Create               | New-AzureRmNetworkInterface        | az network nic create            |
|      Storage account     | Get                  | Get-AzureRmStorageAccount          | ---                              |
|                          | Create               | New-AzureRmStorageAccount          | az storate account create        |
|     Availability set     | Create               | New-AzureRmAvailabilitySet         | az vm availability-set create    |
|        Custom script     | Desired state config | Set-AzureRmVmDscExtension          | ??                               |


