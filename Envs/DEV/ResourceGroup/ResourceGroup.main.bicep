param name string
param location string
param envr string

targetScope = 'subscription'

module rg '../../../Modules/ResourceGroup/ResourceGroup.bicep' = {
  name: 'rg'
  params: {
    name : name
    location: location
    tags: {
      CreatedUsing: 'Bicep'
      CreatorBy: 'Krushna'
      Environment : envr
    }
  }
}
