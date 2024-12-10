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
                echo "Current branch is: ${env.GIT_BRANCH}"
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
                timeout(time: 30, unit: 'MINUTES') 
                {
                    input message: "Approve deployment to apply Terraform changes?", ok: "Yes"
                }
                echo 'approved'
            }


        }
    }
}