import * as definitions from '../bicep/modules/policySetDefinitions.bicep'

targetScope = 'managementGroup'

param location string
param identityResoruceId string
param listOfResourceTypesAllowed array

param setDefinitions definitions.setDefinitionsType = [
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

module done '../allowedLocations/module.bicep' = {
  name: 'bicep-on-fire'
  params: {
    location: location
    identityResoruceId: identityResoruceId
    setDefinitions: setDefinitions
    policyName: 'v2'
    displayName: 'lot of potential - cool'
  }
}
