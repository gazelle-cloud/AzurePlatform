targetScope = 'managementGroup'

param environment string
param roles array

module rbac 'modules/roleAssignment.bicep' = [
  for item in roles: {
    name: 'roleAssignment'
    params: {
      principalType: 'Group'
      principlesId: item.groupid
      roleDefinitions: item.roleName
    }
  }
]