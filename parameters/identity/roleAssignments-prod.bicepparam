using '../../src/identity/roleAssignments.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param gazelleAdminGroupId = readEnvironmentVariable('GAZELLE_GROUP_ID', '')

var azureRoles = loadJsonContent('../AzureRoleDefinitions.json')

param roles = [
  {
    scope: 'platform-${environment}'
    groupid: gazelleAdminGroupId
    roleId: azureRoles.Reader
  }
  {
    scope: 'playground-${environment}'
    groupid: gazelleAdminGroupId
    roleId: azureRoles.Contributor
  }
]
