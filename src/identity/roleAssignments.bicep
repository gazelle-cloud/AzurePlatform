targetScope = 'managementGroup'

param environment string
param roles array

module rbac 'modules/roleAssignment.bicep' = [
  for item in roles: {
    name: 'roleAssignment-${item.roleName}'
    params: {
      principalType: 'Group'
      principlesId: item.value.groupid
      roleDefinitions: item.value.roleName
    }
  }
]
