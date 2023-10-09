pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/azure-cli:latest'
        }
    }

    environment {
        AZURE_SERVICE_PRINCIPAL_ID = "${params.AZURE_SERVICE_PRINCIPAL_ID}"
        AZURE_SERVICE_PRINCIPAL_PASSWORD = "${params.AZURE_SERVICE_PRINCIPAL_PASSWORD}"
        AZURE_TENANT_ID = "${params.AZURE_TENANT_ID}"
    }

    stages {
        // ... rest of the stages ...
    }

    post {
        always {
            // Clean up resources, log out of Azure CLI if necessary
            script {
                sh 'az logout'
            }
        }
    }
}
