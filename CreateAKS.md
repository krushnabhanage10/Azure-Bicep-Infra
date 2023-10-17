
DEV

az deployment group what-if --resource-group krushna_dev_rg --template-file Envs\DEV\AKS.main.bicep --parameters Envs\DEV\DEV.Parameters.json
az deployment group create --resource-group krushna_dev_rg --template-file Envs\DEV\AKS.main.bicep --parameters Envs\DEV\DEV.Parameters.json
                        

PRD

az deployment group what-if --resource-group krushna_prd_rg --template-file Envs\PRD\AKS.main.bicep --parameters Envs\PRD\PRD.Parameters.json
az deployment group create --resource-group krushna_prd_rg --template-file Envs\PRD\AKS.main.bicep --parameters Envs\PRD\PRD.Parameters.json





















Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\AKS.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"

Apply:
New-AzResourceGroupDeployment -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\AKS.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"



Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName krushna_prd_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\AKS.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"

Apply:
New-AzResourceGroupDeployment -ResourceGroupName krushna_prd_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\AKS.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"