targetScope = 'managementGroup'

param principlesId string
param roleDefinitions array
@allowed(['Group', 'ServicePrincipal', 'User' ])
param principalType string

resource rbacAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = [
  for item in roleDefinitions: {
    name: guid(item, managementGroup().name, principlesId)
    properties: {
      principalId: principlesId
      roleDefinitionId: item
      principalType:  principalType
    }
  }
]
