targetScope = 'managementGroup'

param principlesId string
param roleDefinition string

resource rbacAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(roleDefinition, managementGroup().name, principlesId)
  properties: {
    principalId: principlesId
    roleDefinitionId: roleDefinition
    principalType: 'Group'
  }
}
