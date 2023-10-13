
DEV

az deployment group what-if --resource-group krushna_dev_rg --template-file Envs\DEV\AKS.main.bicep --parameters Envs\DEV\DEV.Parameters.json
az deployment group create --resource-group krushna_dev_rg --template-file Envs\DEV\AKS.main.bicep --parameters Envs\DEV\DEV.Parameters.json
                        

PRD

az deployment group what-if --resource-group krushna_prd_rg --template-file Envs\PRD\AKS.main.bicep --parameters Envs\PRD\PRD.Parameters.json
az deployment group create --resource-group krushna_prd_rg --template-file Envs\PRD\AKS.main.bicep --parameters Envs\PRD\PRD.Parameters.json