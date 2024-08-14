import * as definitions from 'module.bicep'

targetScope = 'managementGroup'

param location string
param identityResoruceId string
param listOfAllowedLocations array

param setDefini definitions.setDefinitionsType = [
  {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c'
    policyDefinitionReferenceId: 'allowedResourceLocations'
    parameters: {
      listOfAllowedLocations: {
        value: listOfAllowedLocations
      }
    }
  }
  {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e765b5de-1225-4ba3-bd56-1ac6695af988'
    policyDefinitionReferenceId: 'allowedResourceGroupLocations'
    parameters: {
      listOfAllowedLocations: {
        value: listOfAllowedLocations
      }
    }
  }
]

module done 'module.bicep' = {
  name: 'fooBar'
  params: {
    location: location
    identityResoruceId: identityResoruceId
    setDef: setDefini
    policyName: 'refactor'
    displayName: 'lot of potential'
  }
}
