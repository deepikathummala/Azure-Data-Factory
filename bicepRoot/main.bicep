targetScope='subscription'

param dataFactoryName string
param location string
param resourceGroupName string
param environment string
param deployrg bool
param deployadf bool
param deploylaw bool
param logAnalyticsWorkspaceName string
param retentionInDays int


resource resourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' = if (deployrg) {
  name: resourceGroupName
  location: location
}

resource existingResourceGroup 'Microsoft.Resources/resourceGroups@2024-03-01' existing = if (!deployrg) {
  name: resourceGroupName
}


module logAnalyticsWorkspace '../bicepModules/logAnalyticsWorkspace.bicep' = if (deploylaw) {
  name: 'logAnalyticsWorkspaceDeployment'
  params: {
    logAnalyticsWorkspaceName: logAnalyticsWorkspaceName
    location: location
    retentionInDays: retentionInDays
  }
  scope: existingResourceGroup
}

module dataFactory '../bicepModules/dataFactory.bicep' = if (deployadf) {
  name: 'dataFactoryDeployment'
  params: {
    dataFactoryName: dataFactoryName
    location: location
    logAnalyticsId: logAnalyticsWorkspace.outputs.workspaceId
  }
  scope: existingResourceGroup
}
