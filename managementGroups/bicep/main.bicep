targetScope = 'managementGroup'

param childManagementGroupNames array
param topLevelManagementGroupName string
param managementGroupHierarchy string

module child 'modules/managementGroups.bicep' = [
  for item in childManagementGroupNames: {
    name: 'mgmtGroup-${item}-${managementGroupHierarchy}'
    params: {
      parentManagementGroupId: topLevelManagementGroupName
      managementGroupName: '${item}-${managementGroupHierarchy}'
    }
  }
]

module defaultSettings 'modules/managementGroupSettings.bicep' = if (managementGroupHierarchy == 'prod') {
  name: 'default-managementGroup-settings'
  dependsOn: [
    child
  ]
  params: {
    defaultManagementGroup: 'playground-${managementGroupHierarchy}'
  }
}
