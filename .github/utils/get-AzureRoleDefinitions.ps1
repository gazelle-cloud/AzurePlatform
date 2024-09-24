$existingRoles = Get-Content "AzureRoleDefinitions.json" -Raw | ConvertFrom-Json


$BuildInRoles = Get-AzRoleDefinition | Where-Object { $_.IsCustom -like 'False' } 

function Format-BuildInRoles {
    $roleMappings = @{}
    foreach ($role in $BuildInRoles) {
        $roleName = $role.Name -replace ' ', ''
        $roleId = "/providers/Microsoft.Authorization/roleDefinitions/$($role.Id)"
        $roleMappings[$roleName] = $roleId  
    }
    $sortedRoleMappings = [ordered]@{}
    $roleMappings.GetEnumerator() | Sort-Object Name | ForEach-Object {
        $sortedRoleMappings[$_.Key] = $_.Value
    }

    Write-Output $sortedRoleMappings
}

$totalBuildInRoles = (Format-BuildInRoles).count
$totalExistingRoles = ($existingRoles | Get-Member -MemberType NoteProperty).Count


$buildInRolesJson = Format-BuildInRoles | ConvertTo-Json -Depth 5

$compare = $totalBuildInRoles - $totalExistingRoles
if ($compare -ne 0) {
    Write-Output "update role definitions: $compare"
    $buildInRolesJson | Out-File "AzureRoleDefinitions-a.json"
} else {
    Write-Output "No updates on role definitions"
}