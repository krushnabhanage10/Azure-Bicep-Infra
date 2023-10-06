param name
param location



module rg '../../../Modules/ResourceGroup/ResourceGroup.bicep' = {
    name : name
    location: location
    tags: {
    CreatedUsing: 'Bicep'
    CreatorBy: 'Krushna'
    Environment : 'DEV'
  }
}