param (
    [Parameter(Mandatory = $true)]
    [string]$managementGroup
)


$query = "authorizationresources
    | where type == 'microsoft.authorization/roleassignments'
    | where properties.scope contains '$managementGroup'
    | where properties.roleDefinitionId !contains '18d7d88d-d35e-4fb5-a5c3-7773c20a72d9'
    | project properties.principalId, name"

$rbacAssignments = Search-AzGraph -Query $query -ManagementGroup $managementGroup
$rbacAssignments.Count

foreach ($item in $rbacAssignments) {
    $params = @{
        ObjectId = [string]$item.properties_principalId
        RoleDefinitionId = [string]$item.name
        scope = "/providers/Microsoft.Management/managementGroups/$managementGroup"
    }
    Remove-AzRoleAssignment @params -WhatIf
    Write-Output "----------------"
}

