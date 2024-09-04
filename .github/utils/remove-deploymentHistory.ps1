param (
    [Parameter(Mandatory = $true)]
    [string]$topLevelManagementGroupName,
    [Parameter(Mandatory = $true)]
    [string]$managementSubscscriptionId
)


$deploymants = Get-AzManagementGroupDeployment -ManagementGroupId $topLevelManagementGroupName
$deploymants.Count
$deploymants | foreach-object -ThrottleLimit 25 -Parallel {
    Remove-AzManagementGroupDeployment -Id $_.Id -verbose
}


$deploymants = Get-AzSubscriptionDeployment -Id 'ca29cb06-f5f6-4116-9061-493426c4d70e'
$deploymants.Count
$deploymants | foreach-object -ThrottleLimit 25 -Parallel {
    Remove-AzSubscriptionDeployment -id $_.id -verbose -WhatIf
}