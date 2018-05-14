# ENHANCE CLOUD MANAGEMENT WITH AUTOMATION

### CREATE AN AUTOMATION ACCOUNT
```powershell
New-AzureRmAutomationAccount `
    -ResourceGroup "MyAutomationRG" `
    -Name "FabrikamAutomation" `
    -Location southcentralus
```



### CREATE A NEW AZURE AUTOMATION CREDENTIAL
```powershell
$automationAccountName = "FabrikamAutomation"
$user = "stever"
$pw = ConvertTo-SecureString "PassWord!" -AsPlainText -Force
$cred = New-Object `
    –TypeName System.Management.Automation.PSCredential `
    –ArgumentList $user, $pw

New-AzureRmAutomationCredential `
    -AutomationAccountName $automationAccountName `
    -Name "MyCredential" `
    -Value $cred `
    -ResourceGroupName "MyAutomationRG" Connections
```



### GET A CONNECTION
```powershell
$Conn = Get-AutomationConnection `
    -Name AzureRunAsConnection

Add-AzureRMAccount `
    -ServicePrincipal `
    -Tenant $Conn.TenantID `
    -ApplicationId $Conn.ApplicationID `
    -CertificateThumbprint $Conn.CertificateThumbprint
```



### CREATE A CERTIFICATE
```powershell
$certName = 'MyAutomationCertificate'
$certPath = '.\MyCert.pfx'
$certPwd = ConvertTo-SecureString -String 'Password!' -AsPlainText -Force
$ResourceGroup = "MyAutomationRG"
New-AzureRmAutomationCertificate `
    -AutomationAccountName "FabrikamAutomation" `
    -Name $certName `
    -Path $certPath `
    –Password $certPwd `
    -Exportable `
    -ResourceGroupName $ResourceGroup
```



### CREATE A VARIABLE
```powershell
New-AzureRmAutomationVariable `
    -ResourceGroupName "MyAutomationRG" `
    –AutomationAccountName "FabrikamAutomation" `
    –Name 'MyAutomationVariable' `
    –Encrypted $false –Value 'MyValue'
```



### AUTOMATICALLY SCALE A BASIC TIER APP
```powershell
$resourceGroup = "MyAutomationRG"
$automationAccountName = "FabrikamAutomation"
$TimeZone = Get-TimeZone
$scaleUpScheduleName = "ScaleAppServiceUpSchedule"
$scaleDownScheduleName = "ScaleAppServiceDownSchedule"

New-AzureRMAutomationSchedule `
    –AutomationAccountName $automationAccountName `
    –Name $scaleUpScheduleName `
    -StartTime "10/29/2017 00:00:00" `
    -WeekInterval 1 `
    -DaysOfWeek Friday `
    -ResourceGroupName $resourceGroup `
    -TimeZone $TimeZone.Id

New-AzureRMAutomationSchedule `
    –AutomationAccountName $automationAccountName `
    –Name $scaleDownScheduleName `
    -StartTime "10/29/2017 00:00:00" `
    -WeekInterval 1 `
    -DaysOfWeek Saturday `
    -ResourceGroupName $resourceGroup `
    -TimeZone $TimeZone.Id
```



### REGISTER AN AZURE VM WITH AZURE AUTOMATION DSC
```powershell
Register-AzureRmAutomationDscNode `
    -AzureVMName "WebServer" `
    -NodeConfigurationName "TestConfig.WebServer" `
    -RefreshFrequencyMins "30" `
    -ConfigurationModeFrequencyMins "15" `
    -ConfigurationMode ApplyAndMonitor `
    -AllowModuleOverwrite $true `
    -RebootNodeIfNeeded $false `
    -ActionAfterReboot ContinueConfiguration `
    -AutomationAccountName "FabrikamAutomation" `
    -ResourceGroupName "MyAutomationRG"
```
