pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:jaouherz/ionic-devops-project.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("ionic-app:latest")
                }
            }
        }

        stage('Deploy Container') {
            steps {
                script {
                    // Stop old container if running
                    sh "docker stop ionic-app || true && docker rm ionic-app || true"

                    // Run new container on port 80
                    sh "docker run -d -p 80:80 --name ionic-app ionic-app:latest"
                }
            }
        }
    }
}
