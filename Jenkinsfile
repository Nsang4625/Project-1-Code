pipeline {
    agent any
    tools {
        nodejs 'node16'
        jdk 'jdk17'
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
                ansiblePlaybook(credentialsId: 'server1', installation: 'ansible', inventory: '/var/lib/jenkins/ansible/hosts', playbook: '/home/sang/book1/be.yml', vaultTmpPath: '', extraVars: [workdir:"${env.WORKSPACE}" ])
            }
        }
        stage('Deploy to server1') {
            steps {
                ansibleAdhoc(credentialsId: 'server1', installation: 'ansible', hostKeyChecking: false, inventory: '/var/lib/jenkins/ansible/hosts', hosts: 'server1', become: true, module: 'shell', moduleArguments: 'docker run --net host -d -e DB_PORT=3002 registry.cloudemon.me/project-1/be:latest')
            }
        }
    }
}
