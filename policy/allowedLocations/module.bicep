targetScope = 'managementGroup'

param policyName string = 'allowedLocations'
param displayName string = 'allowed Locations'
param identityResoruceId string
param location string
param setDef setDefinitionsType

var shortenPolicyName = take(policyName, 24)

module setDefinition '../bicep/modules/policySetDefinitions.bicep' = {
  name: 'initiative-${policyName}'
  params: {
    policyName: shortenPolicyName
    displayName: displayName
    setDefinitions: setDef
  }
}

module assignment '../bicep/modules/policyAssignments.bicep' = {
  name: 'assignment-${policyName}'
  params: {
    policyName: shortenPolicyName
    displayName: displayName
    location: location
    identityResourceId: identityResoruceId
    setDefinitionId: setDefinition.outputs.resourceId
  }
}

@export()
type setDefinitionsType = {
    policyDefinitionId: string
    policyDefinitionReferenceId: string
    parameters: object
  }[]
