pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "sharara99/flask-app-pipeline"
    }
    stages {
        stage('Setup') {
            steps {
                git branch: 'main', credentialsId: 'Github', url: 'https://github.com/sharara99/flask_dockerApp.git'
            }
        }
        
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
                    
                    // Log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'DockerHub', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                        sh "docker login -u $DOCKER_USER -p $DOCKER_PASS"
                    }
                    
                    // Push the Docker image to Docker Hub
                    sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                }
            }
        }
        
        stage('Deploy') {
            steps {
                script {
                    echo "Deploying on Kubernetes..."
                    docker.image('bitnami/kubectl:latest').inside {
                        sh "kubectl set image deployment/flask-app flask=${DOCKER_IMAGE}:${BUILD_NUMBER}"
                    }
                }
            }
        }
    }
}
