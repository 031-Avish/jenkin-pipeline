pipeline{
    agent any 
    tools {
        terraform 'Terraform' 
    }
    stages{
        stage('init'){
            steps{
                sh 'terraform init'
            }
        }
    }
}