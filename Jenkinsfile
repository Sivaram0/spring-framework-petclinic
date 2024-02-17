pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven'
    }
    environment {
        SCANNER_HOME = tool 'SonarScanner'
    }
    stages {
        stage('clean workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Checkout from Git') {
            steps {
                git branch: 'main', url: 'https://github.com/Sivaram0/spring-framework-petclinic.git'
            }
        }
        stage('Maven') {
            steps {
                tool 'maven'
                sh 'mvn clean package'
            }
        }
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonar-server') {
                    sh "${SCANNER_HOME}/bin/sonar-scanner \
                        -Dsonar.projectName=spring-framework-petclinic \
                        -Dsonar.projectKey=spring-framework-petclinic \
                        -Dsonar.sources=src/main/java \
                        -Dsonar.java.binaries=target/classes"
                }
            }
        }
    }
}
