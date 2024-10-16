using '../../src/policy/identity.bicep'

var rbacMapping = loadJsonContent('../AzureRoleDefinitions.json')

param workloadName = 'policy'
param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param subscriptionId = readEnvironmentVariable('MANAGEMENT_SUBSCRIPTION_ID', '')
param roleDefinitions = [
  rbacMapping.Contributor
]
