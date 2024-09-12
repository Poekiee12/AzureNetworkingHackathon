module virtualWan 'br/public:avm/res/network/virtual-wan:0.3.0' = {
  name: 'virtualWanDeployment'
  params: {
    // Required parameters
    name: 'VWAN01'
  }
}

module virtualHub 'br/public:avm/res/network/virtual-hub:0.2.2' = {
  name: 'virtualHubDeployment'
  params: {
    // Required parameters
    addressPrefix: '10.3.0.0/16'
    name: 'VWAN01'
    virtualWanId: virtualWan.outputs.resourceId
  }
  dependsOn: [
    virtualWan
  ]
}

module virtualNetwork1 'br/public:avm/res/network/virtual-network:0.4.0' = {
  name: 'virtualNetworkDeployment1'
  params: {
    // Required parameters
    addressPrefixes: [
      '10.40.0.0/16'
    ]
    name: 'VNET01'
    // Non-required parameters
    subnets: [
      {
        addressPrefix: '10.40.0.0/24'
        name: 'Subnet01'
      }
    ]
  }
  dependsOn: [
    virtualHub
  ]
}

module virtualNetwork2 'br/public:avm/res/network/virtual-network:0.4.0' = {
  name: 'virtualNetworkDeployment2'
  params: {
    // Required parameters
    addressPrefixes: [
      '10.41.0.0/16'
    ]
    name: 'VNET02'
    // Non-required parameters
    subnets: [
      {
        addressPrefix: '10.41.0.0/24'
        name: 'Subnet02'
      }
    ]
  }
  dependsOn: [
    virtualHub
  ]
}

module virtualMachine1 'br/public:avm/res/compute/virtual-machine:0.7.0' = {
  name: 'virtualMachineDeployment321'
  params: {
    // Required parameters
    adminUsername: 'LocalAdmin'
    imageReference: {
      offer: 'WindowsServer'
      publisher: 'MicrosoftWindowsServer'
      sku: '2022-datacenter-azure-edition'
      version: 'latest'
    }
    name: 'VM01'
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig01'
            subnetResourceId: virtualNetwork1.outputs.subnetResourceIds[0]
          }
        ]
        nicSuffix: '-nic-01'
      }
    ]
    osDisk: {
      caching: 'ReadWrite'
      diskSizeGB: 128
      managedDisk: {
        storageAccountType: 'Standard_LRS'
      }
    }
    osType: 'Windows'
    vmSize: 'Standard_D2as_v4'
    zone: 0
    // Non-required parameters
    adminPassword: 'Hackathon123!'
    location: 'WestEurope'
    ultraSSDEnabled: false
  }
  dependsOn: [
    virtualNetwork1
  ]
}

module virtualMachine2 'br/public:avm/res/compute/virtual-machine:0.7.0' = {
  name: 'virtualMachineDeployment123'
  params: {
    // Required parameters
    adminUsername: 'LocalAdmin'
    imageReference: {
      offer: 'WindowsServer'
      publisher: 'MicrosoftWindowsServer'
      sku: '2022-datacenter-azure-edition'
      version: 'latest'
    }
    name: 'VM02'
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig01'
            subnetResourceId: virtualNetwork2.outputs.subnetResourceIds[0]
          }
        ]
        nicSuffix: '-nic-01'
      }
    ]
    osDisk: {
      caching: 'ReadWrite'
      diskSizeGB: 128
      managedDisk: {
        storageAccountType: 'Standard_LRS'
      }
    }
    osType: 'Windows'
    vmSize: 'Standard_D2as_v4'
    zone: 0
    // Non-required parameters
    adminPassword: 'Hackathon123!'
    location: 'WestEurope'
    ultraSSDEnabled: false
  }
  dependsOn: [
    virtualNetwork2
  ]
}

// Optionele opdrachten

module virtualNetwork3 'br/public:avm/res/network/virtual-network:0.4.0' = {
  name: 'virtualNetworkDeployment3'
  params: {
    // Required parameters
    addressPrefixes: [
      '10.42.0.0/16'
    ]
    name: 'VNET03'
    // Non-required parameters
    subnets: [
      {
        addressPrefix: '10.42.0.0/24'
        name: 'Subnet03'
      }
      {
        addressPrefix: '10.42.1.0/24'
        name: 'GatewaySubnet'
      }
    ]
  }
  dependsOn: [
    virtualHub
  ]
}

module virtualMachine3 'br/public:avm/res/compute/virtual-machine:0.7.0' = {
  name: 'virtualMachineDeployment213'
  params: {
    // Required parameters
    adminUsername: 'LocalAdmin'
    imageReference: {
      offer: 'WindowsServer'
      publisher: 'MicrosoftWindowsServer'
      sku: '2022-datacenter-azure-edition'
      version: 'latest'
    }
    name: 'VM03'
    nicConfigurations: [
      {
        ipConfigurations: [
          {
            name: 'ipconfig01'
            subnetResourceId: virtualNetwork3.outputs.subnetResourceIds[0]
          }
        ]
        nicSuffix: '-nic-01'
      }
    ]
    osDisk: {
      caching: 'ReadWrite'
      diskSizeGB: 128
      managedDisk: {
        storageAccountType: 'Standard_LRS'
      }
    }
    osType: 'Windows'
    vmSize: 'Standard_D2as_v4'
    zone: 0
    // Non-required parameters
    adminPassword: 'Hackathon123!'
    location: 'WestEurope'
    ultraSSDEnabled: false
  }
  dependsOn: [
    virtualNetwork3
  ]
}

module vpnGateway 'br/public:avm/res/network/vpn-gateway:0.1.3' = {
  name: 'vpnGatewayDeployment123'
  params: {
    // Required parameters
    name: 'VPNGW01'
    virtualHubResourceId: virtualHub.outputs.resourceId
    // Non-required parameters
    location: 'WestEurope'
  }
}

module virtualNetworkGateway 'br/public:avm/res/network/virtual-network-gateway:0.3.0' = {
  name: 'virtualNetworkGatewayDeployment'
  params: {
    // Required parameters
    gatewayType: 'Vpn'
    name: 'VPNGW02'
    skuName: 'VpnGw2AZ'
    vNetResourceId: virtualNetwork3.outputs.resourceId
    // Non-required parameters
    activeActive: true
    allowRemoteVnetTraffic: true
    disableIPSecReplayProtection: true
    enableBgpRouteTranslationForNat: true
    enablePrivateIpAddress: true
    location: 'WestEurope'
    domainNameLabel: [
      'team4'
      'team4-2'
    ]
    publicIpZones: [
      1
      2
      3
    ]
    vpnGatewayGeneration: 'Generation2'
    vpnType: 'RouteBased'
  }
}
