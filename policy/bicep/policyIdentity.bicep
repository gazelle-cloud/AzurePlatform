targetScope = 'managementGroup'

param workloadName string = 'policy'
param environment string
param location string
param subscriptionId string
param roleDefinitions array

var policyIdentityResourceGroupName = 'Identity-${workloadName}-${environment}'

module rg 'modules/resourceGroup.bicep' = {
  scope: subscription(subscriptionId)
  name: 'rg-identity-${workloadName}'
  params: {
    location: location
    resourceGroupName: policyIdentityResourceGroupName
  }
}

module uami 'modules/userAssignedManagedIdentity.bicep' = {
  scope: resourceGroup(subscriptionId, policyIdentityResourceGroupName)
  name: 'uami-${workloadName}'
  params: {
    environment: environment
    workloadName: workloadName
  }
}

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-${workloadName}'
  params: {
    principlesId: uami.outputs.principalId
    roleDefinitions: roleDefinitions
  }
}

output identityResoruceId object = {
  POLICY_RESOURCE_ID: uami.outputs.resourceId
}
