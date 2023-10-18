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
                    def processType = params.PROCESS_TYPE
                    PROCESS_TYPE == 'RG Creation WhatIF and Deployment'
                    echo "Selected process type: ${processType}"

                    def parallelJenkinsfiles = [:]

                    if (processType == 'RG Creation WhatIF and Deployment' || processType == 'VNET and SUBNET Creation WhatIF and Deployment' || processType == 'NSG Creation WhatIF and Deployment' || processType == 'RouteTable Creation WhatIF and Deployment'|| processType == 'AKS Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'RGenkinsfile'                            
                        }
                    } else if (processType == 'RG Creation WhatIF and Deployment' || processType == 'VNET and SUBNET Creation WhatIF and Deployment' || processType == 'NSG Creation WhatIF and Deployment' || processType == 'RouteTable Creation WhatIF and Deployment'|| processType == 'AKS Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'NWJenkinsfile'
                        }
                    } else if (processType == 'RG Creation WhatIF and Deployment' || processType == 'VNET and SUBNET Creation WhatIF and Deployment' || processType == 'NSG Creation WhatIF and Deployment' || processType == 'RouteTable Creation WhatIF and Deployment'|| processType == 'AKS Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'NSGJenkinsfile'
                        }
                    } else if (processType == 'RG Creation WhatIF and Deployment' || processType == 'VNET and SUBNET Creation WhatIF and Deployment' || processType == 'NSG Creation WhatIF and Deployment' || processType == 'RouteTable Creation WhatIF and Deployment'|| processType == 'AKS Creation WhatIF and Deployment') {
                        parallelJenkinsfiles['Deploying'] = {
                            load 'RTJenkinsfile'
                        }
                    } else if (processType == 'RG Creation WhatIF and Deployment' || processType == 'VNET and SUBNET Creation WhatIF and Deployment' || processType == 'NSG Creation WhatIF and Deployment' || processType == 'RouteTable Creation WhatIF and Deployment'|| processType == 'AKS Creation WhatIF and Deployment') {
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
