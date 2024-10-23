targetScope = 'managementGroup'

param environment string
param roles object

module rbac 'modules/roleAssignment.bicep' = [
  for item in items(roles): {
    name: '${item.key}-ass'
    scope: managementGroup('${item.key}-${environment}')
    params: {
      principalType: 'Group'
      principlesId: item.value.groupid
      roleDefinitions: item.value.role
    }
  }
]
