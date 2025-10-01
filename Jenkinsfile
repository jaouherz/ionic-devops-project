pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/jaouherz/ionic-devops-project.git'
            }
        }

        stage('Build Ionic App') {
            steps {
                script {
                    docker.image('node:20-alpine').inside {
                        sh '''
                        npm install -g @ionic/cli
                        npm install
                        ionic build --prod
                        '''
                    }
                }
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
                    sh "docker stop ionic-app || true && docker rm ionic-app || true"
                    sh "docker run -d -p 80:80 --name ionic-app ionic-app:latest"
                }
            }
        }
    }
}
