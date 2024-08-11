using '../bicep/rbac.bicep'

param environment = readEnvironmentVariable('managementGroupHierarchy', '')
param entraIdGroupOwners = [
  '0d6eb039-8df3-4a3d-a4f4-05254113fb9a'
]

param azurePlatformTestPrincipalId = readEnvironmentVariable('AZURE_PLATFORM_TEST_PRINCIPAL_ID', '')
