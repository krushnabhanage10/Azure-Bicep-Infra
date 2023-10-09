pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/azure-cli:latest'
        }
    }

    environment {
        AZURE_SERVICE_PRINCIPAL_ID = credentials('YOUR_AZURE_SP_ID')
        AZURE_SERVICE_PRINCIPAL_PASSWORD = credentials('YOUR_AZURE_SP_PASSWORD')
        AZURE_TENANT_ID = credentials('YOUR_AZURE_TENANT_ID')
    }

    stages {
        stage('Checkout') {
            steps {
                // Check out your source code repository if needed
                // For example, you can use 'git checkout' here
                sh 'git checkout <your-git-branch>'
            }
        }

        stage('Azure Login and Bicep Deployment') {
            steps {
                script {
                    def azLoginCommand = """az login --service-principal -u \${AZURE_SERVICE_PRINCIPAL_ID} -p \${AZURE_SERVICE_PRINCIPAL_PASSWORD} --tenant \${AZURE_TENANT_ID}"""
                    def createResourceGroupCommand = "az group create --name MyResourceGroup --location eastus"
                    def deployBicepCommand = "az deployment group create --resource-group MyResourceGroup --template-file main.bicep"

                    sh "$azLoginCommand"
                    sh "$createResourceGroupCommand"
                    sh "$deployBicepCommand"
                }
            }
        }
    }

    post {
        always {
            emailext body: "The build URL :${env.BUILD_URL} has result ${currentBuild.result}",
                attachLog: true,
                to: 'krushna.bhanage@outlook.com',
                subject: "Status of pipeline - ${currentBuild.fullDisplayName}:${currentBuild.result}"             
            // Clean up resources, log out of Azure CLI if necessary
            script {
                sh 'az logout'
            }
        }
    }
}
