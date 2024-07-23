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
        '/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d'
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
