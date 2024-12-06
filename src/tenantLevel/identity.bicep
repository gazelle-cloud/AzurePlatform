targetScope = 'managementGroup'

param gazellePrincipalId string
param roleDefinitions array

module rbac 'modules/roleAssignments.bicep' = {
  name: 'tenantLevel-identity-rbac'
  params: {
    principlesId: gazellePrincipalId
    roleDefinitions: roleDefinitions
  }
}
