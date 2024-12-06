targetScope = 'managementGroup'

#disable-next-line no-unused-params
param environment string
#disable-next-line no-unused-params
param gazelleAdminGroupId string
param roles array

module rbac 'modules/roleAssignment.bicep' = [
  for item in roles: {
    name: 'identity-roleAssignment-${split(item.roleId,'/')[4]}'
    scope: managementGroup(item.scope)
    params: {
      principlesId: item.groupid
      roleDefinition: item.roleId
    }
  }
]
