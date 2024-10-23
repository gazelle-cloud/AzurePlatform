targetScope = 'managementGroup'

param environment string
param roles array

module rbac 'modules/roleAssignment.bicep' = [
  for item in roles: {
    name: 'roleAssignment'
    params: {
      principalType: 'Group'
      principlesId: item.value.groupid
      roleDefinitions: item.value.roleName
    }
  }
]
