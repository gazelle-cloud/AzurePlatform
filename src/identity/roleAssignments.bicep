targetScope = 'managementGroup'

param environment string
param landingzoneEngineersGroupId string
param roles array

module rbac 'modules/roleAssignment.bicep' = [
  for item in roles: {
    name: 'roleAssignment'
    scope: managementGroup(item.scope)
    params: {
      principalType: 'Group'
      principlesId: item.groupid
      roleDefinitions: item.roleId
    }
  }
]
