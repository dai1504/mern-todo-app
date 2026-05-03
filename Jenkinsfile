pipeline {
    agent any

    stages {
        stage('Pull images') {
            steps {
                sh 'docker pull nguyendai/mern-backend'
                sh 'docker pull nguyendai/mern-frontend'
            }
        }

        stage('Deploy') {
            steps {
                sh 'docker-compose down'
                sh 'docker-compose up -d'
            }
        }
    }
}