pipeline {
    // agent {
    //     docker {
    //         image 'krushnabhanage10/jnlp-slave:latest'
    //         args "--user root --privileged"
    //     }
    // }
    agent {
        label 'vm'
    }
    environment {
    AZ_CRED = credentials('AZ_SPN')
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
        stage('triggerallDEV'){
            parallel{
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
                stage('DEV VNET and SUBNET Creation WhatIF and Deployment') {
                    steps {
                        dir("${workspace}"){
                            script{
                                def whatifnw = "az deployment group what-if --resource-group krushna_dev_rg --template-file ${env.DEVNWTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                def deploynw = "az deployment group create --resource-group krushna_dev_rg --template-file ${env.DEVNWTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                sh "$whatifnw"
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
                                                sh "$deploynw"
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
                stage('DEV NSG Creation WhatIF and Deployment') {
                    steps {
                        dir("${workspace}"){
                            script{
                                def whatifnsg = "az deployment group what-if --resource-group krushna_dev_rg --template-file ${env.DEVNSGTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                def deploynsg = "az deployment group create --resource-group krushna_dev_rg --template-file ${env.DEVNSGTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                sh "$whatifnsg"
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
                                                sh "$deploynsg"
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
                stage('DEV RouteTable Creation WhatIF and Deployment') {
                    steps {
                        dir("${workspace}"){
                            script{
                                def whatifrt = "az deployment group what-if --resource-group krushna_dev_rg --template-file ${env.DEVRTTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                def deployrt = "az deployment group create --resource-group krushna_dev_rg --template-file ${env.DEVRTTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                sh "$whatifrt"
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
                                                sh "$deployrt"
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
                stage('DEV AKS Creation WhatIF and Deployment') {
                    steps {
                        dir("${workspace}"){
                            script{
                                def whatifaks = "az deployment group what-if --resource-group krushna_dev_rg --template-file ${env.DEVAKSTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                def deployaks = "az deployment group create --resource-group krushna_dev_rg --template-file ${env.DEVAKSTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                sh "$whatifaks"
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
                                                sh "$deployaks"
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
                stage('DEV AKS Creation WhatIF and Deployment') {
                    steps {
                        dir("${workspace}"){
                            script{
                                def whatifvm = "az deployment group what-if --resource-group krushna_dev_rg --template-file ${env.DEVVMTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                def deployvm = "az deployment group create --resource-group krushna_dev_rg --template-file ${env.DEVVMTEMPLATEFILEPATH} --parameters ${env.DEVPARAMETERSFILEPATH}"
                                sh "$whatifvm"
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
                                                sh "$deployvm"
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
        stage('triggerallPRD'){
            parallel{
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
                stage('PRD VNET and SUBNET Creation WhatIF and Deployment') {
                    steps{
                        dir("${workspace}"){
                            script{
                                def whatifnw = "az deployment group what-if --resource-group krushna_prd_rg --template-file ${env.PRDNWTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                def deploynw = "az deployment group create --resource-group krushna_prd_rg --template-file ${env.PRDNWTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                sh "$whatifnw"
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
                                                sh "$deploynw"
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
                stage('PRD NSG Creation WhatIF and Deployment') {
                    steps{
                        dir("${workspace}"){
                            script{
                                def whatifnsg = "az deployment group what-if --resource-group krushna_prd_rg --template-file ${env.PRDNSGTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                def deploynsg = "az deployment group create --resource-group krushna_prd_rg --template-file ${env.PRDNSGTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                sh "$whatifnsg"
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
                                                sh "$deploynsg"
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
                stage('PRD RouteTable Creation WhatIF and Deployment') {
                    steps{
                        dir("${workspace}"){
                            script{
                                def whatifrt = "az deployment group what-if --resource-group krushna_prd_rg --template-file ${env.PRDRTTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                def deployrt = "az deployment group create --resource-group krushna_prd_rg --template-file ${env.PRDRTTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                sh "$whatifrt"
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
                                                sh "$deployrt"
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
                stage('PRD AKS Creation WhatIF and Deployment') {
                    steps{
                        dir("${workspace}"){
                            script{
                                def whatifaks = "az deployment group what-if --resource-group krushna_prd_rg --template-file ${env.PRDAKSTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                def deployaks = "az deployment group create --resource-group krushna_prd_rg --template-file ${env.PRDAKSTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                sh "$whatifaks"
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
                                                sh "$deployaks"
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
                stage('PRD VM Creation WhatIF and Deployment') {
                    steps{
                        dir("${workspace}"){
                            script{
                                def whatifvm = "az deployment group what-if --resource-group krushna_prd_rg --template-file ${env.PRDVMTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                def deployvm = "az deployment group create --resource-group krushna_prd_rg --template-file ${env.PRDVMTEMPLATEFILEPATH} --parameters ${env.PRDPARAMETERSFILEPATH}"
                                sh "$whatifvm"
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
                                                sh "$deployvm"
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
    post {
        always {
            emailext body: "The build URL :${env.BUILD_URL} has result ${currentBuild.result}",
                attachLog: true,
                to: 'krushna.bhanage@outlook.com',
                subject: "Status of pipeline - ${currentBuild.fullDisplayName}:${currentBuild.result}"             
        }
    }
}