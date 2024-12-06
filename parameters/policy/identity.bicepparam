using '../../src/policy/identity.bicep'

var azureRoles = loadJsonContent('../AzureRoleDefinitions.json')

param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param subscriptionId = readEnvironmentVariable('MANAGEMENT_SUBSCRIPTION_ID', '')
param roleDefinitions = [
  azureRoles.Contributor
]
