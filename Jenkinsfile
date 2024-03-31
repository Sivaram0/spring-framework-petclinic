/* groovylint-disable CompileStatic, DuplicateStringLiteral */
/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent {
        label 'SONAR'
    }
    tools {
        jdk 'jdk17'
        maven 'maven'
    }
    environment {
        SCANNER_HOME = tool 'sonar-scanner'
    }
    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Git Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Sivaram0/spring-framework-petclinic.git'
            }
        }
        stage('Build and Package') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Reporting') {
            steps {
                junit testResults: '**/target/surefire-reports/TEST-*.xml'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                script {
                    withSonarQubeEnv('sonar') {
                        sh '''$SCANNER_HOME/bin/sonar-scanner \
                -Dsonar.projectName=spring \
                -Dsonar.projectKey=spring \
                -Dsonar.java.binaries=target/classes \
                -Dsonar.inclusions=**/target/petclinic.war'''
                    }
                }
            }
        }
        stage('TRIVY') {
            steps {
                sh 'trivy fs . > trivyfs.txt'
            }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    /* groovylint-disable-next-line DuplicateStringLiteral, NestedBlockDepth */
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh 'docker build -t springfixer .'
                        sh 'docker tag springfixer sivaramaprasaditrajula/springfixer:latest'
                        sh 'docker push sivaramaprasaditrajula/springfixer:latest'
                    }
                }
            }
        }
        stage('TRIVY') {
            steps {
                sh 'trivy fs . > trivyfs.txt'
                sh 'trivy image sivaramaprasaditrajula/springfixer:latest > trivyimage.txt'
            }
        }
        stage('Deploy to Container') {
            steps {
                sh 'docker run -d --name springpetclinic -p 8090:80 sivaramaprasaditrajula/springfixer:latest'
            }
        }
    }
}
