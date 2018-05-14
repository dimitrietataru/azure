# DESIGN ROLE-BASED ACCESS CONTROL (RBAC)

### IMLEMENT ROLE ASSIGNMENT
```powershell
$roleName = "Contributor"
$assigneeName = "cawatson@microsoft.com"
$resourceGroupName = "contoso-app"

New-AzureRmRoleAssignment `
    -RoleDefinitionName $roleName `
    -SignInName $assigneeName '
    -ResourceGroupName $resourceGroupName 
```

```bash
roleName="Contributor"
assigneeName="johndoe@contoso.com"
resourceGroupName="contoso-app"

az role assignment create \
    --role $roleName \
    --assignee $assigneeName \
    --resource-group $resourceGroupName 
```
