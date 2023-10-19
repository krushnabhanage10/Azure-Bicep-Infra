param name string
param location string
param tags object
param properties object

resource vm 'Microsoft.Compute/virtualMachines@2023-07-01' = {
  name: name
  location: location
  tags: tags
  zones: [
    '1'
  ]
  properties: properties
}
