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
                        message: 'Select an option:',
                        parameters: [
                            choice(name: 'RG Creation WhatIF and Deployment', description: 'Run RG Creation WhatIF and Deployment', choices: 'RG Creation WhatIF and Deployment'),
                            choice(name: 'VNET and SUBNET Creation WhatIF and Deployment', description: 'Run VNET and SUBNET Creation WhatIF and Deployment', choices: 'VNET and SUBNET Creation WhatIF and Deployment'),
                            choice(name: 'NSG Creation WhatIF and Deployment', description: 'Run NSG Creation WhatIF and Deployment', choices: 'NSG Creation WhatIF and Deployment'),
                            choice(name: 'RouteTable Creation WhatIF and Deployment', description: 'Run RouteTable Creation WhatIF and Deployment', choices: 'RouteTable Creation WhatIF and Deployment'),
                            choice(name: 'AKS Creation WhatIF and Deployment', description: 'Run AKS Creation WhatIF and Deployment', choices: 'AKS Creation WhatIF and Deployment'),
                        ]

                    if (userInput == 'RG Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'RGenkinsfile'                            
                        }
                    } else if (userInput == 'VNET and SUBNET Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'NWJenkinsfile'
                        }
                    } else if (userInput == 'NSG Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'NSGJenkinsfile'
                        }
                    } else if (userInput == 'RouteTable Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'RTJenkinsfile'
                        }
                    } else if (userInput == 'AKS Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'AKSJenkinsfile'
                        }
                    } else {
                        error('Invalid process type specified.')
                    }

                    parallel parallelJenkinsfiles
                }
            }
        }
    }
}
