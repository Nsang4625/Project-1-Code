pipeline {
    agent any
    tools {
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        registry = 'registry.cloudemon.me'
        gitBranch = 'main'
        gitUrl = 'https://github.com/Nsang4625/Project-1-Code.git'
    }
    stages {
        stage('Clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout') {
            steps {
                git branch:gitBranch, url:gitUrl
            }
        }
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
                sh 'ansible-playbook /home/sang/book1/be.yml'
            }
        }
        stage('Deploy to server1') {
            steps {
                sh 'ansible server1 -a "docker run --net host -e DB_PORT=3002 registry.cloudemon.me/builder/be:latest" '
            }
        }
    }
}
