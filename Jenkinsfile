pipeline {
    agent any

    parameters {
        booleanParam(name: 'PLAN_TERRAFORM', defaultValue: false, description: 'Check to plan terraform changes')
        booleanParam(name: 'APPLY_TERRAFORM', defaultValue: false, description: 'Check to apply terraform changes')
        booleanParam(name: 'DESTROY_TERRAFORM', defaultValue: false, description: 'Check to destroy terraform changes')
    }

    stages {
        stage('Clone TRepository') {
            steps {
                deleteDir()
                git branch: 'main', url: 'https://github.com/Shudhoo/jenkins-terraform-infrastructure-deploy.git'
            }
        }

        stage('Terraform Init') {
            steps {
                    withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-crendentials-shudho', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh 'echo =============================Terraform Init==================================='
                        sh 'terraform init'
                    }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    if (params.PLAN_TERRAFORM) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-crendentials-shudho', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'echo =============================Terraform Plan==================================='
                            sh 'terraform plan'
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                script {
                    if (params.APPLY_TERRAFORM) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-crendentials-shudho', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'echo =============================Terraform Apply==================================='
                            sh 'terraform apply -auto-approve'
                        }
                    }
                }
            }
        }

        stage('Terraform Destroy') {
            steps {
                script {
                    if (params.DESTROY_TERRAFORM) {
                        withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-crendentials-shudho', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                            sh 'echo =============================Terraform Destroy==================================='
                            sh 'terraform destroy -auto-approve'
                        }
                    }
                }
            }
        }
    }
}
