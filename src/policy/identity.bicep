targetScope = 'managementGroup'

param workloadName string = 'policy'
param environment string
param location string = deployment().location
param subscriptionId string
param roleDefinitions array

var policyIdentityResourceGroupName = '${workloadName}-identity-${environment}'

module IdentityResourceGroup 'modules/resourceGroup.bicep' = {
  scope: subscription(subscriptionId)
  name: 'identity-rg-${workloadName}'
  params: {
    location: location
    resourceGroupName: policyIdentityResourceGroupName
  }
}

module uami 'modules/userAssignedManagedIdentity.bicep' = {
  scope: resourceGroup(subscriptionId, policyIdentityResourceGroupName)
  dependsOn: [
    IdentityResourceGroup
  ]
  name: 'identity-uami-${workloadName}'
  params: {
    environment: environment
    workloadName: workloadName
    location: location
  }
}

module rbac 'modules/roleAssignment.bicep' = {
  name: 'policy-identity-rbac'
  params: {
    principlesId: uami.outputs.principalId
    roleDefinitions: roleDefinitions
  }
}

output gitHubEnviromentVariables object = {
  POLICY_IDENTITY_RESOURCE_ID: uami.outputs.resourceId
}
