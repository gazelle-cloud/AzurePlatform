targetScope = 'managementGroup'

param params object

output labName string = params.labName
output subscriptionId string = params.subscriptionId
output subscriptionName string = '${params.labName}-${params.environment}'
output managementGroupName string = params.managementGroupName
output budget int = int(params.budget)


