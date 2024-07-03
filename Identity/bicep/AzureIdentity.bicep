targetScope = 'managementGroup'

param workloadName string
param environment string
param location string
param subscriptionId string = '7e88dc1f-a45d-47dc-b986-785db0fea339'
param identity object

var resourceGroupName = '${workloadName}-${environment}'

module IdentityResourceGroup 'br/public:avm/res/resources/resource-group:0.2.4' = {
  scope: subscription(subscriptionId)
  name: 'crossScope'
  params: {
    name: resourceGroupName
    location: location
  }
}

module managedIdentity 'modules/uami.bicep' = [
  for (item, i) in items(identity): {
    scope: resourceGroup(subscriptionId, resourceGroupName)
    dependsOn: [
      IdentityResourceGroup
    ]
    name: 'uami-${item.key}'
    params: {
      workloadName: item.key
      environment: environment
      federatedCredentials: item.value.federatedCredentials
    }
  }
]

module rbac 'modules/roleAssignment.bicep' = [
  for (item, i) in items(identity): if (item.value.rbac.scope != '') {
    scope: managementGroup(item.value.rbac.scope)
    name: 'role-${item.key}'
    params: {
      principlesId: managedIdentity[i].outputs.principalId
      roleDefinitions: item.value.rbac.roleDefinitions
    }
  }
]

output gitHubEnviromentVariables array = [
  for (item, i) in items(identity): {
    '${item.key}PrincipalId': managedIdentity[i].outputs.principalId
    '${item.key}ResourceId': managedIdentity[i].outputs.resourceId
    '${item.key}ClientId': managedIdentity[i].outputs.clientId
  }
]
