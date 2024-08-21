param (
    [Parameter(Mandatory = $true)]
    [string]$managementSubscscriptionId,
    [Parameter(Mandatory = $true)]
    [string]$topLevelManagementGroupName,
    [Parameter(Mandatory = $true)]
    [string]$workloadIdentityStackName
)


Select-AzSubscription -subscriptionId $managementSubscscriptionId

$subscriptionStacks =  Get-AzSubscriptionDeploymentStack 
Write-Output "deployment stacks to be deleted:"
$subscriptionStacks.name
$subscriptionStacks | foreach-object -ThrottleLimit 5 -Parallel {
    Remove-AzSubscriptionDeploymentStack -ResourceId $_.id -ActionOnUnmanage DeleteAll -Force
}


$managementGroupStacks = Get-AzManagementGroupDeploymentStack -ManagementGroupId $topLevelManagementGroupName
Write-Output "deployment stacks to be deleted:"
$managementGroupStacks.name
$subscriptionStacks | foreach-object -ThrottleLimit 5 -Parallel {
    Remove-AzSubscriptionDeploymentStack -ResourceId $_.id -ActionOnUnmanage DeleteAll -Force
}