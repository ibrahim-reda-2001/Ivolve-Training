pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'ivolve-app1'
        K8S_NAMESPACE = 'default'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/ibrahim-reda-2001/APP1.git'

            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh "docker build -t ibrahimelmsery1/${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                        sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
                        sh "docker push ibrahimelmsery1/${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    }
                }
            }
        }
        stage('show files') {
            steps {
                sh "ls -la"
            }
        }

        stage('Update Deployment YAML') {
            steps {
                script {
                    sh """
                    sed -i 's|image: .*|image: ibrahimelmsery1/${DOCKER_IMAGE}:${BUILD_NUMBER}|' deploy.yml
                    cat deploy.yml  # Debugging: Show the updated file
                    """
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                
                    sh '''
                    kubectl apply -f deploy.yml
                    '''
                
            }
        }
    }
}
