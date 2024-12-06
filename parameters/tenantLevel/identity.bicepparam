using '../../src/tenantLevel/identity.bicep'

var azureRoles = loadJsonContent('../AzureRoleDefinitions.json')

param gazellePrincipalId = readEnvironmentVariable('GAZELLE_PRINCIPAL_ID', '')
param roleDefinitions = [
  azureRoles.Contributor
  azureRoles.UserAccessAdministrator
]
