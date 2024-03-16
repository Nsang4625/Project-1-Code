pipeline {
    agent any
    tools {
        nodejs 'node16'
        jdk 'jdk17'
    }
    environment {
        registry = 'registry.cloudemon.me'
        gitBranch = 'main'
        gitUrl = 'https://github.com/Nsang4625/Project-1-Code.git'
    }
    stages {
        stage('Install dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Integration test') {
            steps {
                sh 'npm run test:coverage'
            }
        }
        stage('Build and push image to registry') {
            steps {
                ansiblePlaybook(credentialsId: 'server1', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: '/home/sang/book1/be.yml', vaultTmpPath: '')
            }
        }
        stage('Deploy to server1') {
            steps {
                ansibleAdhoc(credentialsId: 'server1', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', pattern: 'server1', module: 'shell', moduleArguments: 'docker run --net host -e DB_PORT=3002 registry.cloudemon.me/builder/be:latest')
            }
        }
    }
}
