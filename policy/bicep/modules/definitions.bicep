targetScope = 'managementGroup'

param name string
param properties object

resource definitions 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: name
  properties: properties
}
