pipeline{
    agent any 
    tools {
        terraform 'Terraform' 
    }
    environment {
        AWS_ACCESS_KEY_ID     = credentials('awsAccessKeyId')
        AWS_SECRET_ACCESS_KEY = credentials('awsSecretAccessKey')
        AWS_SESSION_TOKEN = credentials('awsSessionToken')
    }
    stages{
        stage('init'){
            steps{
                sh 'terraform init'
            }
        }

        stage('plan')
        {
            steps{
                sh 'terraform plan'
            }
        }

        stage('apply')
        {
            when {
                branch 'main'
            }
            steps{
                timeout(time: 30, unit: 'MINUTES') { // Timeout after 30 minutes
                    input message: "Approve deployment to apply Terraform changes?", ok: "Yes"

                echo 'approved '
            }
        }


    }
}