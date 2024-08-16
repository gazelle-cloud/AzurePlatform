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
    $principalId = [string]$item.properties_principalId
    $name = [string]$item.name
    Remove-AzRoleAssignment -ObjectId $principalId -RoleDefinitionId $name -WhatIf
    Write-Output "----------------"
}

