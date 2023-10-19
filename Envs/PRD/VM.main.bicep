param name string
param location string
param envr string
var vmpassword = 'AdminVM202310#'

var vmconfigs = [
  {
    name: 'prd-linux-vm-01'
    properties: {
      hardwareProfile: {
        vmSize: 'Standard_B1s'
      }
      storageProfile: {
        imageReference: {
          publisher: 'canonical'
          offer: '0001-com-ubuntu-server-jammy'
          sku: '22_04-lts-gen2'
          version: 'latest'
        }
        osDisk: {
          osType: 'Linux'
          name: 'prd-linux-vm-01_OsDisk_1_20231010'
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
          deleteOption: 'Delete'
          diskSizeGB: 32
        }
        dataDisks: []
        diskControllerType: 'SCSI'
      }
      osProfile: {
        computerName: 'prd-linux-vm-01'
        adminUsername: 'VMAdmin'
        linuxConfiguration: {
          disablePasswordAuthentication: false
          provisionVMAgent: true
          patchSettings: {
            patchMode: 'ImageDefault'
            assessmentMode: 'ImageDefault'
          }
          enableVMAgentPlatformUpdates: false
        }
        secrets: []
        allowExtensionOperations: true
        requireGuestProvisionSignal: true
      }
      securityProfile: {
        uefiSettings: {
          secureBootEnabled: true
          vTpmEnabled: true
        }
        securityType: 'TrustedLaunch'
      }
      networkProfile: {
        networkInterfaces: [
          {
            id: '/subscriptions/4a84c9d0-d7e4-4681-be42-dd358c9f1ea0/resourceGroups/krushna_prd_rg/providers/Microsoft.Network/networkInterfaces/prd-linux-vm-20231010'
            properties: {
              deleteOption: 'Delete'
            }
          }
        ]
      }
    }
  }
  {
    name: 'prd-windows-vm-01'
    properties: {
      hardwareProfile: {
        vmSize: 'Standard_B1s'
      }
      storageProfile: {
        imageReference: {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2022-datacenter-azure-edition-hotpatch'
          version: 'latest'
        }
        osDisk: {
          osType: 'Windows'
          name: 'prd-windows-vm-01_OsDisk_1_20231010'
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
          deleteOption: 'Delete'
        }
        dataDisks: []
        diskControllerType: 'SCSI'
      }
      osProfile: {
        computerName: 'prd-windows-vm-'
        adminUsername: 'VMAdmin'
        windowsConfiguration: {
          provisionVMAgent: true
          enableAutomaticUpdates: true
          patchSettings: {
            patchMode: 'AutomaticByPlatform'
            automaticByPlatformSettings: {
              rebootSetting: 'IfRequired'
              bypassPlatformSafetyChecksOnUserSchedule: false
            }
            assessmentMode: 'ImageDefault'
            enableHotpatching: true
          }
          enableVMAgentPlatformUpdates: false
        }
        secrets: []
        allowExtensionOperations: true
        requireGuestProvisionSignal: true
      }
      securityProfile: {
        uefiSettings: {
          secureBootEnabled: true
          vTpmEnabled: true
        }
        securityType: 'TrustedLaunch'
      }
      networkProfile: {
        networkInterfaces: [
          {
            id: '/subscriptions/4a84c9d0-d7e4-4681-be42-dd358c9f1ea0/resourceGroups/krushna_prd_rg/providers/Microsoft.Network/networkInterfaces/prd-windows-vm-20231010'
            properties: {
              deleteOption: 'Delete'
            }
          }
        ]
      }
    }
  }
]


module az_vm '../../Modules/VM/VM.bicep' = [ for vmconfig in vmconfigs : {
  name: vmconfig.name
  params:{
    name: vmconfig.name
    location: location
    tags: {
      CreatedUsing: 'Bicep'
      CreatorBy: 'Krushna'
      Environment : envr
    }
    properties: vmconfig.properties
  }
}]
