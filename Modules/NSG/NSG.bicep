param name string
param location string
param tags object
param securityrules array





resource nsg 'Microsoft.Network/networkSecurityGroups@2021-02-01' = {
  name: name
  location: location
  tags: tags
  properties: [for securityrule in securityrules: {
    securityRules: securityrules
  }
}