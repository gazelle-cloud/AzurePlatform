targetScope = 'managementGroup'

// param environment string
// // param entraIdGroupOwners array
// param topLevelManagementGroupName string

// // module entraIdGroupReaders 'modules/groups.bicep' = {
// //   name: 'entra-readers'
// //   params: {
// //     displayName: 'azurePlatform-readers-${environment}'
// //     owners: entraIdGroupOwners
// //   }
// // }

// var rbacMapping = loadJsonContent('../../AzureRoleDefinitions.json')

// module rbac 'modules/roleAssignment.bicep' = {
//   name: 'rbac-AzureManagementProd'
//   scope: managementGroup(topLevelManagementGroupName)
//   params: {
//     principlesId: '682960f7-aade-477f-80d9-abb9774d7242'
//     principalType: 'Group'
//     roleDefinitions: [
//       rbacMapping.Reader
//     ]
//   }
// }
