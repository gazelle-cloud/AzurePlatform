targetScope = 'tenant'

param invoiceSectionName string

resource billingAccount 'Microsoft.Billing/billingAccounts@2024-04-01' existing = {
  name: '32b4d9dc-1c92-51df-adb3-f41a27e34168:39e00ade-d1e2-4447-ba05-81383d79706b_2018-09-30'
}

resource billingProfile 'Microsoft.Billing/billingAccounts/billingProfiles@2024-04-01' existing = {
  name: '21082db8-3fc4-48c0-a011-4de71365bbca'
  parent: billingAccount
}


resource invoice 'Microsoft.Billing/billingAccounts/billingProfiles/invoiceSections@2024-04-01' = {
  name: invoiceSectionName
  parent: billingProfile
  properties: {
    displayName: invoiceSectionName
  }
}

output invoiceSectionResourceId string = invoice.id
