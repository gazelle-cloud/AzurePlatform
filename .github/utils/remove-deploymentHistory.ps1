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


$deploymants = Get-AzSubscriptionDeployment -SubscriptionId $managementSubscscriptionId
$deploymants.Count
$deployments | foreach-object -ThrottleLimit 25 -Parallel {
    Remove-AzSubscriptionDeployment -Id $_.Id -verbose
}