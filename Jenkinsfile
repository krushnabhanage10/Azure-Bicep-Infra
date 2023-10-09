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

    stages {
        stage('Choose Environment to Plan/Deploy'){
            steps{
                script{
                    def DeployTo = input(
                        message: "Select Env to Deploy",
                        ok: 'Proceed',
                        submitter: 'krushna', // List of users who can approve
                        parameters: [choice(choices: ['DEV', 'PRD'], description: 'Approval', name: 'DeployTo')]
                    )
                echo "Selected Env is : $DeployTo"
                def DeployToList = DeployTo.split(',')

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
                if ( DeployTo == 'DEV') {
                    stage('DEV RG Creation WhatIF and Deployment') {
                        steps {
                            dir("${workspace}"){
                                script{
                                    sh 'az login --service-principal -u $AZ_CRED_CLIENT_ID -p $AZ_CRED_CLIENT_SECRET -t $AZ_CRED_TENANT_ID'
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
                }
                else if ( DeployTo == 'PRD') {
                    stage('PRD RG Creation WhatIF and Deployment') {
                        steps{
                            dir("${workspace}"){
                                script{
                                    sh 'az login --service-principal -u $AZ_CRED_CLIENT_ID -p $AZ_CRED_CLIENT_SECRET -t $AZ_CRED_TENANT_ID'
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
 