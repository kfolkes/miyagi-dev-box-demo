param location string = resourceGroup().location
param searchServiceName string
param location string = resourceGroup().location
param apiManagementName string
param eventHubNamespaceName string
param eventHubName string
param location string = resourceGroup().location
param searchServiceName string




module deployEventHub './modules/eventhub.bicep' = {
  name: 'EventHub'
  params: {
    eventHubNamespaceName: eventHubNamespaceName
    eventHubName: eventHubName
    location: location
  }
}

module deployAPIM './modules/apim.bicep' = {
  name: 'APIM'
  scope: resourceGroup()
  params: {
    apiManagementName: apiManagementName
    location: location
  }
  dependsOn:[
    deployEventHub
  ]
}

param sku object = {
  name: 'standard'
}

resource searchService 'Microsoft.Search/searchServices@2021-04-01-Preview' = {
  name: searchServiceName
  location: location
 
  properties: {
    semanticSearch: 'free'
  }
  sku:sku
  
}