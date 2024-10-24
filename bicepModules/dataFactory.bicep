targetScope='resourceGroup'

param dataFactoryName string
param location string
param logAnalyticsId string

resource dataFactory 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: dataFactoryName
  location: location
  tags: {}
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}

resource adfDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${dataFactoryName}-diagnostics'
  dependsOn: [
    dataFactory
  ]
  properties: {
    workspaceId: logAnalyticsId
    logs: [
      {
        category: 'PipelineRuns'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
      {
        category: 'TriggerRuns'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
      {
        category: 'ActivityRuns'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        timeGrain: 'PT1M'
        enabled: true
        retentionPolicy: {
          enabled: false
          days: 0
        }
      }
    ]
  }
  scope: dataFactory
}
