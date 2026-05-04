pipeline {
    agent any

    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest')
    }

    environment {
        VPS_IP = credentials('vps-ip')
        SSH_KEY = 'devops-key'
        APP_DIR = '/home/ubuntu/app'
    }

    stages {
        stage('Deploy') {
            steps {
                sshagent(credentials: [SSH_KEY]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${VPS_IP} '
                        set -e
                        cd ${APP_DIR}
                        export IMAGE_TAG=${IMAGE_TAG}

                        docker compose pull
                        docker compose up -d

                        docker image prune -f
                    '
                    """
                }
            }
        }
    }

    post {
        success { echo "✅ Deploy SUCCESS: ${IMAGE_TAG}" }
        failure { echo "❌ Deploy FAILED" }
    }
}