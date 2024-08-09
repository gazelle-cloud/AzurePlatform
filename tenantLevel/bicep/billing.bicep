targetScope = 'managementGroup'

param invoiceSections array

module invoice 'modules/invoice.bicep' = [
  for item in invoiceSections: {
    name: 'invoiceSection-${item}'
    params: {
      invoiceSectionName: item
    }
  }
]

output invoiceSections array = [
  for (item, i) in invoiceSections: {
    section: invoice[i].outputs.invoiceSectionResourceId
  }
]
