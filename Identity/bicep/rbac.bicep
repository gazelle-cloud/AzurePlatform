targetScope = 'managementGroup'

param environment string
param entraIdGroupOwners array

module entraIdGroupReaders 'modules/groups.bicep' = {
  name: 'entra-readers'
  params: {
    displayName: 'azurePlatform-readers-${environment}'
    owners: entraIdGroupOwners
  }
}


param azurePlatformTestPrincipalId string

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-to-move-subscription'
  scope: managementGroup('playground-${environment}')
  params: {
    principlesId: azurePlatformTestPrincipalId
    roleDefinitions: [
      '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
      '/providers/Microsoft.Authorization/roleDefinitions/adb29209-aa1d-457b-a786-c913953d2891'
    ]
  }
}
