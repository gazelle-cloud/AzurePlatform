targetScope = 'managementGroup'


param billingAccountName string
param billingProfileName string
param invoiceSections array

module invoice 'modules/invoice.bicep' = [
  for item in invoiceSections: {
    name: 'invoiceSection-${item}'
    params: {
      billingAccountName: billingAccountName
      billingProfileName: billingProfileName
      invoiceSectionName: item
    }
  }
]

output invoiceSections array = [
  for (item, i) in invoiceSections: {
    '${item[i]}_billingScope' : invoice[i].outputs.invoiceSectionResourceId
  }
]
