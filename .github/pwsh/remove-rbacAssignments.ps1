param (
    [Parameter(Mandatory = $true)]
    [string]$managementGroup
)

$query = "authorizationresources
| where type == 'microsoft.authorization/roleassignments'
| where properties.scope contains '$managementGroup'
| where properties.roleDefinitionId !contains '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
| project id"

$rbacAssignments = Search-AzGraph -Query $query -ManagementGroup $managementGroup
$rbacAssignments.Count


# $getRoles = Get-AzRoleAssignment -scope '/providers/Microsoft.Management/managementGroups/$managementGroup' `
# | Where-Object { $_.RoleAssignmentId -like "*${$managementGroup}*" `
#         -and $_.RoleDefinitionName -ne 'User Access Administrator' }

$rbacAssignments | ForEach-Object {
    $role = $_
    $role | Remove-AzRoleAssignment -Force
}
