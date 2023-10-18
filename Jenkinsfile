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
                            def loadrg = load 'RGJenkinsfile'
                            loadrg.run()
                            echo 'Running RG WhatIF'
                            stage('DEV RG Creation WhatIF and Deployment') {
                                steps {
                                    dir("${workspace}"){
                                        script{
                                            def whatifrg = "az deployment sub what-if --location ${env.LOCATION} --template-file ${env.DEVRGTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                            def deployrg = "az deployment sub create --location ${env.LOCATION} --template-file ${env.DEVRGTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                            sh "$whatifrg"
                                            script {
                                                def approved = false
                                                timeout(time: 30, unit: 'MINUTES') {
                                                    while (!approved) {
                                                        def approval = input(
                                                            message: "Do you approve Stage ${env.STAGE_NAME}?",
                                                            ok: 'Proceed',
                                                            submitter: 'krushna', // List of users who can approve
                                                            parameters: [choice(choices: ['Yes', 'No'], description: 'Approval', name: 'APPROVAL')]
                                                        )

                                                        if (approval == 'Yes') {
                                                            approved = true
                                                            echo "Stage ${env.STAGE_NAME} approved, proceeding to Stage ${env.STAGE_NAME}"
                                                            sh "$deployrg"
                                                        } else if (approval == 'No') {
                                                            echo "Stage ${env.STAGE_NAME} approval denied, proceeding to the next stage"
                                                            approved = true // Set approved to true to exit the loop
                                                        } else {
                                                            echo "Invalid response. Please select 'Yes' or 'No'."
                                                            sleep(30) // Wait for 30 seconds before checking again (adjust as needed)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            stage('PRD RG Creation WhatIF and Deployment') {
                                steps{
                                    dir("${workspace}"){
                                        script{
                                            def whatifrg = "az deployment sub what-if --location ${env.LOCATION} --template-file ${env.PRDRGTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                            def deployrg = "az deployment sub create --location ${env.LOCATION} --template-file ${env.PRDRGTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                            sh "$whatifrg"
                                            script {
                                                def approved = false
                                                timeout(time: 30, unit: 'MINUTES') {
                                                    while (!approved) {
                                                        def approval = input(
                                                            message: "Do you approve Stage ${env.STAGE_NAME}?",
                                                            ok: 'Proceed',
                                                            submitter: 'krushna', // List of users who can approve
                                                            parameters: [choice(choices: ['Yes', 'No'], description: 'Approval', name: 'APPROVAL')]
                                                        )

                                                        if (approval == 'Yes') {
                                                            approved = true
                                                            echo "Stage ${env.STAGE_NAME} approved, proceeding to Stage ${env.STAGE_NAME}"
                                                            sh "$deployrg"
                                                        } else if (approval == 'No') {
                                                            echo "Stage ${env.STAGE_NAME} approval denied, proceeding to the next stage"
                                                            approved = true // Set approved to true to exit the loop
                                                        } else {
                                                            echo "Invalid response. Please select 'Yes' or 'No'."
                                                            sleep(30) // Wait for 30 seconds before checking again (adjust as needed)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    // if (userInput.RunVNETWhatIF) {
                    //     parallelStages['VNET WhatIF'] = {
                    //         // Run VNET and SUBNET Creation WhatIF and Deployment
                    //         load 'NWJenkinsfile'
                    //         echo 'Running VNET WhatIF'
                    //     }
                    // }
                    // if (userInput.RunNSGWhatIF) {
                    //     parallelStages['NSG WhatIF'] = {
                    //         // Run NSG Creation WhatIF and Deployment
                    //         load 'NSGJenkinsfile'
                    //         echo 'Running NSG WhatIF'
                    //     }
                    // }
                    // if (userInput.RunRouteTableWhatIF) {
                    //     parallelStages['RouteTable WhatIF'] = {
                    //         // Run RouteTable Creation WhatIF and Deployment
                    //         load 'RTJenkinsfile'
                    //         echo 'Running RouteTable WhatIF'
                    //     }
                    // }
                    // if (userInput.RunAKSWhatIF) {
                    //     parallelStages['AKS WhatIF'] = {
                    //         // Run AKS Creation WhatIF and Deployment
                    //         load 'AKSJenkinsfile'
                    //         echo 'Running AKS WhatIF'
                    //     }
                    // }
                    // Execute the parallel stages
                    parallel parallelStages
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

