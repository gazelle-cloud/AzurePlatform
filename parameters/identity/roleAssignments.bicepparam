using '../../src/identity/roleAssignments.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')

var rbacMapping = loadJsonContent('../AzureRoleDefinitions.json')

param roles = [
  {
    roleName: rbacMapping.Reader
    groupid: readEnvironmentVariable('ENTRA_LANDINGZONE_ENGINEERS_GROUP_ID', '')
  }
]
