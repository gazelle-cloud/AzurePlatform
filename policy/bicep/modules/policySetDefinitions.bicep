targetScope = 'managementGroup'

param policyName string
param displayName string
param setDefinitions array

resource initiative 'Microsoft.Authorization/policySetDefinitions@2023-04-01' = {
  name: policyName
  properties: {
    displayName: displayName
    policyDefinitions: setDefinitions
  }
}



output resourceId string = initiative.id
output name string = initiative.name
