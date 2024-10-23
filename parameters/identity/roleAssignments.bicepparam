using '../../src/identity/roleAssignments.bicep'

// param environment = readEnvironmentVariable('managementGroupHierarchy', '')
// param topLevelManagementGroupName = readEnvironmentVariable('TOP_LEVEL_MANAGEMENTGROUP_NAME', '')
param landingzoneEngineersGroupId = readEnvironmentVariable('ENTRA_LANDINGZONE_ENGINEERS_GROUP_ID','')
