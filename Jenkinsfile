pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "160122737074/flask-demo"      // ✅ Replace with your Docker Hub username
        IMAGE_TAG = "latest"
    }

    stages {

        stage('Checkout Source') {
            steps {
                git branch: 'main', url: 'https://github.com/buttivaishnavi/docker-cicd.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo "Building Docker image..."
                bat "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                echo "Logging into Docker Hub..."
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-credentials',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                echo "Pushing Docker image to Docker Hub..."
                bat "docker push ${DOCKER_IMAGE}:${IMAGE_TAG}"
            }
        }

        stage('Cleanup') {
            steps {
                echo "Removing local Docker image..."
                bat "docker rmi ${DOCKER_IMAGE}:${IMAGE_TAG} || echo 'Image not found or already removed'"
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker environment'
            bat 'docker logout'
        }
        success {
            echo '✅ Docker Image build and push successful!'
        }
        failure {
            echo '❌ Pipeline failed. Check logs for errors.'
        }
    }
}
