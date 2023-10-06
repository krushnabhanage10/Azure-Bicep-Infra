targetScope = 'subscription'

param name string
param location string
param tags object


resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: name
  location: location
  tags: tags
  properties: {}
}
