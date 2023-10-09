
###### Follow below commands to create RGs for DEV and PRD Envs.


# DEV:
Plan:
Get-AzDeploymentWhatIfResult -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"

Apply:
New-AzDeployment -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"



# PRD:
Plan:
Get-AzDeploymentWhatIfResult -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"

Apply:
New-AzDeployment -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\ResourceGroup\ResourceGroup.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"
