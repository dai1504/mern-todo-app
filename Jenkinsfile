pipeline {
    agent any

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest')
    }

    environment {
        VPS_IP = credentials('vps-ip')
        SSH_KEY = 'devops-key'
    }

    stages {

        stage('Check SSH') {
            steps {
                sshagent(credentials: [SSH_KEY]) {
                    sh "ssh -o StrictHostKeyChecking=no ubuntu@${VPS_IP} 'echo OK'"
                }
            }
        }

        stage('Deploy') {
            steps {
                sshagent(credentials: [SSH_KEY]) {
                    sh """
                    ssh ubuntu@${VPS_IP} '
                        export IMAGE_TAG=${IMAGE_TAG} &&
                        cd ~/app &&
                        docker compose pull &&
                        docker compose up -d
                    '
                    """
                }
            }
        }

        stage('Verify') {
            steps {
                sshagent(credentials: [SSH_KEY]) {
                    sh "ssh ubuntu@${VPS_IP} 'docker ps'"
                }
            }
        }
    }

    post {
        success {
            echo "✅ Deploy success: ${IMAGE_TAG}"
        }
        failure {
            echo "❌ Deploy failed"
        }
    }
}