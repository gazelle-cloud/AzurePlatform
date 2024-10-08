import * as definitions from '../../../src/policy/modules/assignment.bicep'

targetScope = 'managementGroup'

param policyName string = 'allowedResourceTypes'
param displayName string = 'allowed resource types'
param location string = deployment().location
param identityResoruceId string
#disable-next-line no-unused-params
param topLevelManagementGroupName string
param listOfResourceTypesAllowed array = [
  'Microsoft.ManagedIdentity/userAssignedIdentities'
  'Microsoft.ManagedIdentity/userAssignedIdentities/federatedIdentityCredentials'
  'Microsoft.OperationalInsights/workspaces'
  'Microsoft.Resources/deploymentStacks'
  'Microsoft.Resources/resourceGroups'
  'Microsoft.Resources/tags'
]

param initiative definitions.setDefinitionsType = [
  {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/a08ec900-254a-4555-9bf5-e42af04b5c5c'
    policyDefinitionReferenceId: 'allowedResources'
    parameters: {
      listOfResourceTypesAllowed: {
        value: listOfResourceTypesAllowed
      }
    }
  }
]

module assignment '../../../src/policy/modules/assignment.bicep' = {
  name: 'policy-${policyName}'
  params: {
    location: location
    identityResourceId: identityResoruceId
    setDefinitions: initiative
    policyName: policyName
    displayName: displayName
  }
}
