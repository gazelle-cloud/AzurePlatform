targetScope = 'managementGroup'

param policies array
param location string
param identityResoruceId string

module assinments 'modules/policy.bicep' = [
  for item in policies: {
    name: 'policy-${item.name}'
    scope: managementGroup('online-test')
    params: {
      location: location
      identityResourceId: identityResoruceId
      policyName: item.name
      policyProperties: item.properties
    }
  }
]
