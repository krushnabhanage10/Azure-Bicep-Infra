DEV

az deployment group what-if --resource-group krushna_dev_rg --template-file C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\DEV\VM.main.bicep --parameters C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json
az deployment group create --resource-group krushna_dev_rg --template-file C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\DEV\VM.main.bicep --parameters C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json
                        

PRD


az deployment group what-if --resource-group krushna_prd_rg --template-file C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\PRD\VM.main.bicep --parameters C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json
az deployment group create --resource-group krushna_PRD_rg --template-file C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\PRD\VM.main.bicep --parameters C:\Users\kbhanage\Documents\Personal-Learnings\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json







Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\VM.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"

Apply:
New-AzResourceGroupDeployment -ResourceGroupName krushna_dev_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\VM.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\DEV\DEV.Parameters.json"






Get-AzResourceGroupDeploymentWhatIfResult -ResourceGroupName krushna_prd_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\VM.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"

Apply:
New-AzResourceGroupDeployment -ResourceGroupName krushna_prd_rg -Location centralus -TemplateFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\VM.main.bicep" -TemplateParameterFile "C:\Users\krushna.baghate\Documents\Azure-Bicep-Infra\Envs\PRD\PRD.Parameters.json"