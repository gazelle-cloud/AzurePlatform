using '../../src/policy/policyAssignments.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID', '')
param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param policies = [
  {
    name: 'done'
    displayName: 'from Params done'
    setDefinitions: [
      {
        policyDefinitionId: '/providers/Microsoft.Management/managementGroups/gazelle-test/providers/Microsoft.Authorization/policyDefinitions/st_allowCrossTenantReplication'
        policyDefinitionReferenceId: 'st_allowCrossTenantReplication'
        parameters: {
          effect: {
            value: 'Modify'
          }
        }
      }
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/818719e5-1338-4776-9a9d-3c31e4df5986'
        policyDefinitionReferenceId: 'logAnalytics'
        parameters: {
          effect: {
            value: 'DeployIfNotExists'
          }
          diagnosticSettingName: {
            value: 'withLoveFromBicep'
          }
          categoryGroup: {
            value: 'allLogs'
          }
          logAnalytics: {
            value: '/subscriptions/ca29cb06-f5f6-4116-9061-493426c4d70e/resourcegroups/monitoring-test/providers/microsoft.operationalinsights/workspaces/la-monitoring-test'
          }
        }
      }
    ]
  }
  {
    name: 'somethingCool'
    displayName: 'something cool'
    setDefinitions: [
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a08ec900-254a-4555-9bf5-e42af04b5c5c'
        policyDefinitionReferenceId: 'allowedResources'
        parameters: {
          listOfResourceTypesAllowed: {
            value: [
              'Microsoft.ManagedIdentity/userAssignedIdentities'
              'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials'
              'Microsoft.OperationalInsights/workspaces'
              'Microsoft.Resources/deploymentStacks'
              'Microsoft.Resources/resourceGroups'
              'Microsoft.Resources/tags'
            ]
          }
        }
      }
    ]
  }
]
