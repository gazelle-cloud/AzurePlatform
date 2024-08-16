param (
    [Parameter(Mandatory = $true)]
    [string]$managementGroup = "gazelle-test"
)

$getRoles = Get-AzRoleAssignment -scope '/providers/Microsoft.Management/managementGroups/$managementGroup' `
| Where-Object { $_.RoleAssignmentId -like "*${$managementGroup}*" `
        -and $_.RoleDefinitionName -ne 'User Access Administrator'}

$getRoles | ForEach-Object {
    $role = $_
    $role | Remove-AzRoleAssignment -Force
}
