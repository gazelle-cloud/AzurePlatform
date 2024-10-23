using '../../src/identity/roleAssignments.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')

var rbacMapping = loadJsonContent('../AzureRoleDefinitions.json')

param roles = [
  {
    roleName: [
      rbacMapping.Reader
    ]
    groupid: 'e6aadad8-0177-4a02-b803-06f3eb2fda49'
  }
]
