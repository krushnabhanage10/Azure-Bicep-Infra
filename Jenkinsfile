pipeline {
    agent {
        docker {
            image 'krushnabhanage10/jnlp-slave:latest'
            args "--user root --privileged"
        }
    }
    environment {
    AZ_CRED = credentials('AZ_SPN')
    }

    parameters {
        string(name: 'PROCESS_TYPES', description: 'Select the process(es) to run (comma-separated)', defaultValue: '')
    }

    stages {
        stage('Load Environment Variables') {
            steps {
                script {
                    def envProperties = [:]
                    def envFile = readFile 'env.properties'
                    envFile.readLines().each { line ->
                        def (key, value) = line.tokenize('=').collect { it.trim() }
                        envProperties[key] = value
                    }
                    envProperties.each { key, value ->
                        env[key] = value
                    }
                }
            }
        }
        stage('Logging In to Azure'){
            steps{
                script{
                    sh 'az login --service-principal -u $AZ_CRED_CLIENT_ID -p $AZ_CRED_CLIENT_SECRET -t $AZ_CRED_TENANT_ID'
                }
            }
        }
        stage('Determine Infra Steps to Deploy') {
            steps {
                script {
                    def userInput = input(
                        id: 'userInput', 
                        message: 'Do you want to run the following stages?',
                        parameters: [
                            booleanParam(name: 'RunRGWhatIF', defaultValue: false, description: 'Run RG Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunVNETWhatIF', defaultValue: false, description: 'Run VNET and SUBNET Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunNSGWhatIF', defaultValue: false, description: 'Run NSG Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunRouteTableWhatIF', defaultValue: false, description: 'Run RouteTable Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunAKSWhatIF', defaultValue: false, description: 'Run AKS Creation WhatIF and Deployment?')
                        ]
                    )

                    // Check the user's choices and execute stages accordingly
                    if (userInput.RunRGWhatIF) {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'RGenkinsfile'                            
                        }
                    }
                    if (userInput.RunVNETWhatIF) {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'NWJenkinsfile'
                        }
                    }
                    if (userInput.RunNSGWhatIF) {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'NSGJenkinsfile'
                        }
                    }
                    if (userInput.RunRouteTableWhatIF) {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'RTJenkinsfile'
                        }
                    }
                    if (userInput.RunAKSWhatIF) {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'AKSJenkinsfile'
                        }
                    }
                    parallel parallelJenkinsfiles
                }
            }
        }
    }
}
