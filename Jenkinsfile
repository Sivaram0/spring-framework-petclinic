/* groovylint-disable CompileStatic */
/* groovylint-disable-next-line CompileStatic */
pipeline {
    agent {
        label 'SONAR'
    }
    stages {
        stage('git checkout') {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/Sivaram0/spring-framework-petclinic.git'
                }
            }
        }
    }
}
