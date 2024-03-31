/* groovylint-disable CompileStatic, DuplicateStringLiteral */
/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent {
        label 'SONAR'
    }
    tools {
        jdk 'jdk17'
        maven 'maven'
        sonarQubeScanner 'sonar-scanner' // Use the correct tool name for SonarQube scanner
    // Ensure that 'trivy' is installed and available in the PATH for the following stages
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
                withSonarQubeEnv('sonar') {
                    sh '''$SCANNER_HOME/bin/sonar-scanner \
                    -Dsonar.projectName=spring \
                    -Dsonar.projectKey=spring'''
                }
            }
        }
        stage('TRIVY FS SCAN') {
            steps {
                sh 'trivy fs . > trivyfs.txt'
            }
        }
        stage('Docker Build & Push') {
            steps {
                script {
                    /* groovylint-disable-next-line DuplicateStringLiteral, NestedBlockDepth */
                    withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
                        sh 'docker build --build-arg TMDB_V3_API_KEY=4b44f3548a8cd7c67f528d7acf819e87 -t springfixer .'
                        sh 'docker tag springfixer sivaramaprasaditrajula/springfixer:latest'
                        sh 'docker push sivaramaprasaditrajula/springfixer:latest'
                    }
                }
            }
        }
        stage('TRIVY') {
            steps {
                sh 'trivy image sivaramaprasaditrajula/springfixer:latest > trivyimage.txt'
            }
        }
        stage('Deploy to Container') {
            steps {
                sh 'docker run -d --name springpetclinic -p 8087:80 sivaramaprasaditrajula/springfixer:latest'
            }
        }
    }
}
