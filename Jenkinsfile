pipeline{
    agent any 
    tools{
        Terraform
    }
    stages{
        stage('init'){
            steps{
                sh 'terraform init'
            }
        }
    }
}