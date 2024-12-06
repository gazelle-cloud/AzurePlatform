using '../../src/tenantLevel/identity.bicep'

var azureRoles = loadJsonContent('../AzureRoleDefinitions.json')

param azurePlatformPrincipalId = readEnvironmentVariable('AZURE_PLATFORM_PRINCIPAL_ID', '')
param roleDefinitions = [
  azureRoles.Contributor
  azureRoles.UserAccessAdministrator
]
