using '../../src/identity/roleAssignments.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')

var rbacMapping = loadJsonContent('../AzureRoleDefinitions.json')
var landingzoneEngineersGroupId = readEnvironmentVariable('ENTRA_LANDINGZONE_ENGINEERS_GROUP_ID', '')

param roles = {
  platform: [
    {
      role: rbacMapping.Reader
      groupid: landingzoneEngineersGroupId
    }
  ]
}
