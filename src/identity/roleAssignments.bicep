targetScope = 'managementGroup'

param environment string
param landingzoneEngineersGroupId string
param roles array

module rbac 'modules/roleAssignment.bicep' = [
  for item in roles: {
    name: 'roleAssignment-${split(item.roleId,'/')[4]}'
    scope: managementGroup(item.scope)
    params: {
      principlesId: item.groupid
      roleDefinition: item.roleId
    }
  }
]
