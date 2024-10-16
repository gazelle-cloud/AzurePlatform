targetScope = 'managementGroup'

param policies array
param location string = deployment().location
param identityResoruceId string
param environment string

module online 'modules/assignment.bicep' = [
  for item in policies: {
    name: item.name
    scope: managementGroup('online-${environment}')
    params: {
      location: location
      displayName: item.displayName
      identityResourceId: identityResoruceId
      policyName: item.name
      setDefinitions: item.setDefinitions
    }
  }
]

module platform 'modules/assignment.bicep' = [
  for item in policies: {
    name: item.name
    scope: managementGroup('platform-${environment}')
    params: {
      location: location
      displayName: item.displayName
      identityResourceId: identityResoruceId
      policyName: item.name
      setDefinitions: item.setDefinitions
    }
  }
]
