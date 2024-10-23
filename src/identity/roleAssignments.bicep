targetScope = 'managementGroup'

param environment string
param topLevelManagementGroupName string
param landingzoneEngineersGroupId string

var rbacMapping = loadJsonContent('../../parameters/AzureRoleDefinitions.json')

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-AzureManagementProd'
  scope: managementGroup('${topLevelManagementGroupName}-${environment}')
  params: {
    principlesId: landingzoneEngineersGroupId
    principalType: 'Group'
    roleDefinitions: [
      rbacMapping.Reader
    ]
  }
}
