# This repo contains basic modules for creating azure infra from scratch.

Subscription based Deployment: 
New-AzDeployment -Whatif 
New-AzDeployment -Confirm








Get-AzDeploymentWhatIfResult -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\DEV.Parameters.json"

New-AzDeployment -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\DEV.Parameters.json"







ResourceGroup based Deployment: 
New-AzResourceGroupDeployment -Whatif
New-AzResourceGroupDeployment -Confirm