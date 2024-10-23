using '../../src/identity/roleAssignments.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param landingzoneEngineersGroupId = readEnvironmentVariable('ENTRA_LANDINGZONE_ENGINEERS_GROUP_ID', '')
var rbacMapping = loadJsonContent('../AzureRoleDefinitions.json')

param roles = [
  {
    scope: 'platform-${environment}'
    groupid: landingzoneEngineersGroupId
    roleId: rbacMapping.Reader
  }
  {
    scope: 'playground-${environment}'
    groupid: landingzoneEngineersGroupId
    roleId: rbacMapping.Contributor
  }
]
