# Azure: PowerShell and CLI

|        Chapter I         | Action               | PowerShell                         | Azure CLI                        |
|:------------------------:|:--------------------:|:-----------------------------------|:---------------------------------|
|      Resource group      | Create               | New-AzureRmResourceGroup           | az group create                  |
|     App service plan     | Create               | New-AzureRmAppServicePlan          | az appservice plan create        |
|         Web app          | Get                  | Get-AzureRmWebApp                  | ---                              |
|                          | Create               | New-AzureRmWebApp                  | az webapp create                 |
|                          | Application settings | Set-AzureRmWebApp                  | az webapp config appsettings set |
|                          | Diagnostic logs      | Set-AzureRmWebApp                  | az webapp log config             |
|                          | Diagnostic logs get  | Save-AzureWebSiteLog               | az webapp log download           |
|       Deployment slot    | Create               | New-AzureRmWebAppSlot              | az webapp deployment slot create |
|                          | Swap                 | Swap-AzureRmWebAppSlot             | az webapp deployment slot swap   |
|       Traffic manager    | Create               | New-AzureRmTrafficManagerProfile   | ---                              |
|                          | Add endpoints        | New-AzureRmTrafficManagerEndpoint  | ---                              |
|                          | Remove endpoints     | Remove-AzureRmTrafficManagerEndp.. | ---                              |
|                          | Disable endpoints    | Disable-AzureRmTrafficManagerEnd.. | ---                              |

|        Chapter II        | Action               | PowerShell                         | Azure CLI                        |
|:------------------------:|:--------------------:|:-----------------------------------|:---------------------------------|
|      Virtual machine     | Create               | New-AzureRmVirtualMachine          | az vm create                     |
|                          | Create from ARM      | New-AzureRmResourceGroupDeployment | az group deployment create       |
|                          | Configure            | New-AzureRmVMConfig                | ---                              |
|                          | Operating system     | New-AzureRmVMOperatingSystem       | ---                              |
|                          | OS disk config       | Set-AzureRmVMOSDisk                | ---                              |
|                          | Source image         | Set-AzureRmVMSourceImage           | az vm image list                 |
|                          | Stop                 | Stop-AzureRmVM                     | az vm dealocate                  |
|       Advanced VM        | Custom script        | Set-AzureRmVmCustomScriptExtension | az vm extension set              |
|                          | Resize               | Update-AzureRmVM                   | az vm resize                     |
|       VM scale set       | Create               | New-AzureRmVirtualMachine          | az vm create                     |
|      Virtual network     | Create               | New-AzureRmVirtualNetwork          | az network vnet create           |
|                          | Create subnet        | New-AzureRmVirtualNetworkSubnetC.. | az network vnet subnet create    |
|                          | Create public IP     | New-AzureRmPublicIpAddress         | az network public-ip create      |
|                          | Create NSG           | New-AzureRmNetworkSecurityGroup    | az network nsg create            |
|                          | Create NSG rule      | New-AzureRmNetworkSecurityRuleCo.. | az network nsg rule create       |
|     Network interface    | Create               | New-AzureRmNetworkInterface        | az network nic create            |
|      Storage account     | Get                  | Get-AzureRmStorageAccount          | ---                              |
|                          | Create               | New-AzureRmStorageAccount          | az storate account create        |
|     Availability set     | Create               | New-AzureRmAvailabilitySet         | az vm availability-set create    |
|    Container services    | Create               | ---                                | az acr create                    |
|                          | Login                | ---                                | az acr login                     |
|                          | List                 | ---                                | az acr list                      |
|                          | Configure            | ---                                | az acs kubernetes                |
|                          | Verify               | ---                                | kubectl get nodes                |
