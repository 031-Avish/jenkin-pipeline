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
                echo $AWS_ACCESS_KEY_ID
                sh 'terraform init'
                sh 'aws s3 ls'
            }
        }
    }
}