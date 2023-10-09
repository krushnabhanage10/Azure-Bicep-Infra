pipeline {
    agent {
        docker {
            image 'miqm/bicep-cli:latest'
        }
    }
    environment {
    AZ_CRED = credentials('AZ_SPN')
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
                    script{
                        sh 'az login --service-principal -u $AZ_CRED_CLIENT_ID -p $AZ_CRED_CLIENT_SECRET -t $AZ_CRED_TENANT_ID'
                        def whatifrg = "az deployment sub what-if --location ${env.LOCATION} --template-file ${env.RGTEMPLATEFILEPATH} --parameters ${env.PARAMETERSFILEPATH}"
                        def deployrg = "az deployment sub create --location ${env.LOCATION} --template-file ${env.RGTEMPLATEFILEPATH} --parameters ${env.PARAMETERSFILEPATH}"
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
        }
    }
}
