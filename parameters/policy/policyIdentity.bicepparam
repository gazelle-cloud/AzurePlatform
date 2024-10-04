using '../../src/policy/policyIdentity.bicep'

param workloadName = 'policy'
param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param subscriptionId = readEnvironmentVariable('MANAGEMENT_SUBSCRIPTION_ID', '')
param roleDefinitions = [
  '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
]
