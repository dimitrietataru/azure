# CHAPTER I

|            ##            | Action        | PowerShell                       | Azure CLI                        |
|:------------------------:|:--------------|:---------------------------------|:---------------------------------|
|      Resource group      | Create        | New-AzureRmResourceGroup         | az group create                  |
|     App service plan     | Get           | Get-AzureRmWebApp                | ---                              |
|                          | Create        | New-AzureRmAppServicePlan        | az appservice plan create        |
|                          | Configure     | Set-AzureRmWebApp                | az webapp config appsettings set |
|         Web app          | Create        | New-AzureRmWebApp                | az webapp create                 |
|       Deployment slot    | Create        | New-AzureRmWebAppSlot            | az webapp deployment slot create |
|                          | Swap          | Swap-AzureRmWebAppSlot           | az webapp deployment slot swap   |
