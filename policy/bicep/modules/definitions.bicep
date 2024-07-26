targetScope = 'managementGroup'

param customName string?
param customProperties object?

resource definition 'Microsoft.Authorization/policyDefinitions@2023-04-01' = {
  name: customName
  properties: customProperties
}
output foo  object = {
  policyDefinitionId: definition.id
  policyDefinitionReferenceId: definition.name
}
