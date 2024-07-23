using '../bicep/AzureIdentity.bicep'

param location = 'francecentral'
param environment = ''
param workloadName = 'identity'
param subscriptionId = ''
param identity = {
  policy: {
    federatedCredentials: {}
    RBAC: {
      scope: 'gazelle-${environment}'
      roleDefinitions: [
        '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
      ]
    }
  }
  // landingzone: {
  //   federatedCredentials: {
  //     github: {
  //       audiences: ['api://AzureADTokenExchange']
  //       issuer: 'https://token.actions.githubusercontent.com'
  //       subject: 'repo:gazelle-cloud/lz:environment:test'
  //     }
  //   }
  // }
}
