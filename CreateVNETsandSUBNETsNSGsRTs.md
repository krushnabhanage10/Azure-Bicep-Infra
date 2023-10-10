###### Follow below commands to create Vnets and Subnets for DEV and PRD Envs.


# DEV:
Plan:
Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\VirtualNetwork.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"

Apply:
New-AzResourceGroupDeployment -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\VirtualNetwork.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"



Plan:
Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\RouteTable.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"

Apply:
New-AzResourceGroupDeployment -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\VirtualNetwork.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"




# PRD:
Plan:
Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName krushna_prd_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\VirtualNetwork.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"

Apply:
New-AzResourceGroupDeployment -ResourceGroupName krushna_prd_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\VirtualNetwork.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"