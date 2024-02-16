pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Checkout the code from Git
                git 'https://github.com/Sivaram0/spring-framework-petclinic.git'

                // Build the Java project
                sh 'mvn clean package'
            }
        }
        stage('Test') {
            steps {
                // Run tests
                sh 'mvn test'
            }
        }
    }
}