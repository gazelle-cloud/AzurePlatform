using '../bicep/AzureIdentity.bicep'

param location = 'francecentral'
param environment = 'tst'
param workloadName = 'identity'
param subscriptionId = ''
param identity = {
  alert: {
    federatedCredentials: {
      github: {
        audiences: ['api://AzureADTokenExchange']
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:gazelle-cloud/azurePlatform:environment:test'
      }
      testv2: {
        audiences: ['api://AzureADTokenExchange']
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:gazelle-cloud/azurePlatform:environment:v2'
      }
    }
    RBAC: {
      scope: 'platform-test'
      roleDefinitions: [
        '/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7'
        '/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d'
      ]
    }
  }
  policy: {
    federatedCredentials: {}
    RBAC: {
      scope: 'playground-test'
      roleDefinitions: [
        '/providers/Microsoft.Authorization/roleDefinitions/acdd72a7-3385-48ef-bd42-f606fba81ae7'
        '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
      ]
    }
  }
  landingzone: {
    federatedCredentials: {
      github: {
        audiences: ['api://AzureADTokenExchange']
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:gazelle-cloud/lz:environment:test'
      }
    }
    RBAC: {
      scope: 'online-test'
      roleDefinitions: [
        '/providers/Microsoft.Authorization/roleDefinitions/7f951dda-4ed3-4680-a7ca-43fe172d538d'
      ]
    }
  }
  emtpy: {
    federatedCredentials: {}
    RBAC: {
      scope: ''
      roleDefinitions: []
    }
  }
}
