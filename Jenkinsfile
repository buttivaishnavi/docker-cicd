pipeline {
    agent any

    stages {

        stage('Checkout Source') {
            steps {
                git branch: 'main', url: 'https://github.com/<your_username>/<your_repo>.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t <your_dockerhub_username>/flask-demo:latest .'
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASS', usernameVariable: 'DOCKER_USER')]) {
                    bat 'docker login -u %DOCKER_USER% -p %DOCKER_PASS%'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                bat 'docker push <your_dockerhub_username>/flask-demo:latest'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up Docker environment'
            bat 'docker logout'
        }
    }
}
