function move-subscription {
    param (
        [Parameter(Mandatory = $true)]
        [string]$managementGroup,
        [Parameter(Mandatory = $true)]
        [string]$managementSubscriptionId
    )
    
    Select-AzSubscription -Subscription $managementSubscriptionId

    $query = "resourcecontainers
      | where type == 'microsoft.resources/subscriptions'
      | where properties['managementGroupAncestorsChain'] contains '$managementGroup'
      | project subscriptionId"

    $subscriptions = Search-AzGraph -Query $query
    $subscriptions.Count
    
    foreach ($item in $subscriptions) {
        $id = [string]$item.subscriptionId
        New-AzManagementGroupSubscription -GroupName $managementGroup -SubscriptionId $id -WhatIf
        Write-Output "----------------"
    }
}
