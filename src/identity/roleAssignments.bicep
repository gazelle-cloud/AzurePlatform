targetScope = 'managementGroup'

param environment string
param landingzoneEngineersGroupId string
param roles array

module rbac 'modules/roleAssignment.bicep' = [
  for item in roles: {
    name: 'roleAssignment-${take(split(item.roleId[0],'/'),4)}'
    scope: managementGroup(item.scope)
    params: {
      principalType: 'Group'
      principlesId: item.groupid
      roleDefinitions: item.roleId
    }
  }
]

// output abc array = [
//   for item in roles: {
//     foo: take(split(item.roleDefinitions, '/'), 4)
//   }
// ]
