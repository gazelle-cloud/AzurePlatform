targetScope = 'managementGroup'

param childManagementGroupNames array
param topLevelManagementGroupName string
param environment string

module child 'modules/managementGroups.bicep' = [
  for item in childManagementGroupNames: {
    name: 'tenantLevel-${item}-${environment}'
    params: {
      parentManagementGroupId: topLevelManagementGroupName
      managementGroupName: '${item}-${environment}'
    }
  }
]

module defaultSettings 'modules/managementGroupSettings.bicep' = if (environment == 'prod') {
  name: 'tenantLevel-defaultSettings'
  dependsOn: [
    child
  ]
  params: {
    defaultManagementGroup: 'playground-${environment}'
  }
}
