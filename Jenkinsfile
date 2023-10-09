pipeline {
    agent {
        docker {
            image 'miqm/bicep-cli:latest'
        }
    }
    stages {
        stage('Load Environment Variables') {
            steps {
                script {
                    def envProperties = [:]

                    // Load environment variables from the file
                    def envFile = readFile 'env.properties'
                    envFile.readLines().each { line ->
                        def (key, value) = line.tokenize('=').collect { it.trim() }
                        envProperties[key] = value
                    }

                    // Set all environment variables from the file
                    envProperties.each { key, value ->
                        env[key] = value
                    }
                }
            }
        }
        stage('RG Creation WhatIF and Deployment') {
            steps {
                dir("${workspace}"){
                script withCredentials([azureServicePrincipal('AZ_SPN')]) {
                    sh 'az login --service-principal -u $AZURE_CLIENT_ID -p $AZURE_CLIENT_SECRET -t $AZURE_TENANT_ID'}{
                        def whatifrg = "az deployment sub what-if --location ${location} --template-file ${rgtemplatefilepath} --parameters @${parametersfilepath}"
                        def deployrg = "az deployment sub create --location ${location} --template-file ${rgtemplatefilepath} --parameters @${parametersfilepath}
                        sh "$azLoginCommand"
                        sh "$whatifrg"
                        input("Click 'Proceed' to deploy the Bicep template")
                        sh "$deployrg"
                    }
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
