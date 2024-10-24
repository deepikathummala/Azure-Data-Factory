using '../bicepRoot/main.bicep'

param dataFactoryName = 'adf-uc5-dev-neu-001'
param location = 'North Europe'
param resourceGroupName = 'rg-uc5-dev-neu-001'
param environment = 'dev'
param deployrg = false
param deployadf = false
param logAnalyticsWorkspaceName = 'law-uc5-dev-neu-001'
param retentionInDays = 90
param deploylaw = false
