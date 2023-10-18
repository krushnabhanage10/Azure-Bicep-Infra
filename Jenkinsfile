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
                // script {
                //     def userInput = input(
                //         id: 'userInput', 
                //         message: 'Do you want to run the following stages?',
                //         parameters: [
                //             booleanParam(name: 'RunRGWhatIF', defaultValue: false, description: 'Run RG Creation WhatIF and Deployment?'),
                //             booleanParam(name: 'RunVNETWhatIF', defaultValue: false, description: 'Run VNET and SUBNET Creation WhatIF and Deployment?'),
                //             booleanParam(name: 'RunNSGWhatIF', defaultValue: false, description: 'Run NSG Creation WhatIF and Deployment?'),
                //             booleanParam(name: 'RunRouteTableWhatIF', defaultValue: false, description: 'Run RouteTable Creation WhatIF and Deployment?'),
                //             booleanParam(name: 'RunAKSWhatIF', defaultValue: false, description: 'Run AKS Creation WhatIF and Deployment?')
                //         ]
                //     )
                //     def parallelStages = [:]
                //     // Check the user's choices and execute stages accordingly
                //     if (userInput.RunRGWhatIF) {
                //         parallelStages.add('RG WhatIF': {
                //             // Run RG Creation WhatIF and Deployment
                //             echo 'Running RG WhatIF'
                //             load 'RGenkinsfile'  
                //         })
                //     }
                //     if (userInput.RunVNETWhatIF) {
                //         parallelStages.add('VNET WhatIF': {
                //             // Run VNET and SUBNET Creation WhatIF and Deployment
                //             load 'NWJenkinsfile'
                //             echo 'Running VNET WhatIF'
                //         })
                //     }
                //     if (userInput.RunNSGWhatIF) {
                //         parallelStages.add('NSG WhatIF': {
                //             // Run NSG Creation WhatIF and Deployment
                //             load 'NSGJenkinsfile'
                //             echo 'Running NSG WhatIF'
                //         })
                //     }
                //     if (userInput.RunRouteTableWhatIF) {
                //         parallelStages.add('RouteTable WhatIF': {
                //             // Run RouteTable Creation WhatIF and Deployment
                //             load 'RTJenkinsfile'
                //             echo 'Running RouteTable WhatIF'
                //         })
                //     }
                //     if (userInput.RunAKSWhatIF) {
                //         parallelStages.add('AKS WhatIF': {
                //             load 'AKSJenkinsfile'
                //             echo 'Running AKS WhatIF'
                //         })
                //     }
                //     // Execute the parallel stages
                //     parallel(parallelStages)
                // }
            
            script {
                    def userInput = input(
                        id: 'userInput', 
                        message: 'Do you want to run the following stages in parallel?',
                        parameters: [
                            booleanParam(name: 'RunRGWhatIF', defaultValue: false, description: 'Run RG Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunVNETWhatIF', defaultValue: false, description: 'Run VNET and SUBNET Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunNSGWhatIF', defaultValue: false, description: 'Run NSG Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunRouteTableWhatIF', defaultValue: false, description: 'Run RouteTable Creation WhatIF and Deployment?'),
                            booleanParam(name: 'RunAKSWhatIF', defaultValue: false, description: 'Run AKS Creation WhatIF and Deployment?')
                        ]
                    )
                    
                    // Create a map to hold parallel stages
                    def parallelStages = [:]
                    
                    if (userInput.RunRGWhatIF) {
                        parallelStages['RG WhatIF'] = {
                            // Run RG Creation WhatIF and Deployment
                            load 'RGJenkinsfile'
                            echo 'Running RG WhatIF'
                        }
                    }
                    if (userInput.RunVNETWhatIF) {
                        parallelStages['VNET WhatIF'] = {
                            // Run VNET and SUBNET Creation WhatIF and Deployment
                            load 'NWJenkinsfile'
                            echo 'Running VNET WhatIF'
                        }
                    }
                    if (userInput.RunNSGWhatIF) {
                        parallelStages['NSG WhatIF'] = {
                            // Run NSG Creation WhatIF and Deployment
                            load 'NSGJenkinsfile'
                            echo 'Running NSG WhatIF'
                        }
                    }
                    if (userInput.RunRouteTableWhatIF) {
                        parallelStages['RouteTable WhatIF'] = {
                            // Run RouteTable Creation WhatIF and Deployment
                            load 'RTJenkinsfile'
                            echo 'Running RouteTable WhatIF'
                        }
                    }
                    if (userInput.RunAKSWhatIF) {
                        parallelStages['AKS WhatIF'] = {
                            // Run AKS Creation WhatIF and Deployment
                            load 'AKSJenkinsfile'
                            echo 'Running AKS WhatIF'
                        }
                    }
                    
                    // Execute the parallel stages
                    parallel parallelStages
                }
            }
        }
    }
}

