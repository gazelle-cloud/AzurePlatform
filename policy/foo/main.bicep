targetScope = 'managementGroup'

param favPolicyValue string
// param anotherPolicyValue string
param laEffect string
param diagnosticSettingName string
param categoryGroup string
param logAnalytics string
param identityResoruceId string
param location string

var randomCucstomDfinition = loadJsonContent('customDefinitions/st_vnetAclrRules.json')

module customDefinition '../bicep/modules/policyDefinitions.bicep' = {
  name: 'custom-policy-definition'
  params: {
    policyName: randomCucstomDfinition.name
    policyProperties: randomCucstomDfinition.properties
  }
}

module setDefinition '../bicep/modules/policySetDefinitions.bicep' = {
  name: 'random-setDefinition'
  params: {
    policyName: 'something-cool'
    setDeinitions: [
      {
        policyDefinitionId: customDefinition.outputs.resourcrId
        policyDefinitionReferenceId: customDefinition.outputs.name
        parameters: {
          effect: {
            value: favPolicyValue
          }
        }
      }
      {
        policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/818719e5-1338-4776-9a9d-3c31e4df5986'
        policyDefinitionReferenceId: 'logAnalytics'
        parameters: {
          effect: {
            value: laEffect
          }
          diagnosticSettingName: {
            value: diagnosticSettingName
          }
          categoryGroup: {
            value: categoryGroup
          }
          logAnalytics: {
            value: logAnalytics
          }
        }
      }
    ]
  }
}

module assignment '../bicep/modules/policyAssignments.bicep' = {
  name: 'random-assignment'
  params: {
    policyName: setDefinition.outputs.name
    displayName: setDefinition.outputs.name
    location: location
    identityResourceId: identityResoruceId
    setDefinitionId: setDefinition.outputs.resourceId
  }
}
