targetScope = 'managementGroup'

param landingzoneEngineersGroupId string

var rbacMapping = loadJsonContent('../../parameters/AzureRoleDefinitions.json')

module rbac 'modules/roleAssignment.bicep' = {
  name: 'rbac-AzureManagementProd'
  params: {
    principlesId: landingzoneEngineersGroupId
    principalType: 'Group'
    roleDefinitions: [
      rbacMapping.Reader
    ]
  }
}
