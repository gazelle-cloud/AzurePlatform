targetScope = 'managementGroup'

param azurePlatformPrincipalId string
param roleDefinitions array

module rbac 'modules/roleAssignments.bicep' = {
  name: 'tenantLevel-identity-rbac'
  params: {
    principlesId: azurePlatformPrincipalId
    roleDefinitions: roleDefinitions
  }
}
