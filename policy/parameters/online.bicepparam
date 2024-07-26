using '../bicep/main-assignments.bicep'

param identityResoruceId = readEnvironmentVariable('POLICY_RESOURCE_ID', '')
param location = readEnvironmentVariable('AZURE_DEFAULT_LOCATION', '')
param environment = readEnvironmentVariable('environment', '')

param policies = [
  loadJsonContent('assignments/allowedLocations.json')
  loadJsonContent('assignments/allowedResourceTypes.json')
]
