targetScope = 'subscription'

param labName string
param environment string
param location string
param githubOrganizationName string
param githubRepoName string


resource identityResourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: 'landingzone-${labName}-${environment}'
  location: location
}

module identity 'br/public:avm/res/managed-identity/user-assigned-identity:0.2.1' = {
  scope: identityResourceGroup
  name: 'lz-managedIdentity-${labName}'
  params: {
    name: 'id-${labName}-${environment}'
    location: location
    federatedIdentityCredentials: [
      {
        name: 'landingzoneOwner'
        audiences: [
          'api://AzureADTokenExchange'
        ]
        issuer: 'https://token.actions.githubusercontent.com'
        subject: 'repo:${githubOrganizationName}/${githubRepoName}:environment:${environment}'
      }
    ]
  }
}

module rbacAdmin 'roleAssignments.bicep' = {
  name: 'lz-rbac-serviceConnection'
  params: {
    principalId: identity.outputs.principalId
    rbacId: [
      '/providers/Microsoft.Authorization/roleDefinitions/f58310d9-a9f6-439a-9e8d-f62e7b41a168'
      '/providers/Microsoft.Authorization/roleDefinitions/b24988ac-6180-42a0-ab88-20f7382dd24c'
    ]
  }
}

output clientId string = identity.outputs.clientId
output principalId string = identity.outputs.principalId
output resourceId string = identity.outputs.resourceId
