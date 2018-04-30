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
