###### Follow below commands to create RGs for DEV and PRD Envs.


# DEV:
Get-AzDeploymentWhatIfResult -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\DEV.Parameters.json"
New-AzDeployment -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\DEV.Parameters.json"


# PRD:
Get-AzDeploymentWhatIfResult -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\ResourceGroup\PRD.Parameters.json"
New-AzDeployment -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\ResourceGroup\PRD.Parameters.json"
