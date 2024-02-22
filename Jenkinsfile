pipeline {
    agent any
    tools {
        jdk 'jdk17'
        maven 'maven'
    }
    environment {
        SCANNER_HOME = tool 'SonarScanner'
        ARTIFACTORY_SERVER = credentials('JFROG')
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
        stage('build and package') {
            steps {
                rtMavenRun(
                    tool: 'maven', // Tool name from Jenkins configuration
                    pom: 'pom.xml',
                    goals: 'clean install',
                // deployerId: 'SPC_DEPLOYER'
                )
                rtPublishBuildInfo(
                    serverId: 'hudson'
                )
            }
        }
        stage('reporting') {
            steps {
                junit testResults: '**/target/surefire-reports/TEST-*.xml'
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
        // stage('quality gate') {
        //     steps {
        //         script {
        //             waitForQualityGate abortPipeline: false, credentialsId: 'sonar-server'
        //         }
        //     }
        // }
        // stage('Docker Build & Push') {
        //     steps {
        //         script {
        //             withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
        //                 sh 'docker build --build-arg TMDB_V3_API_KEY=<yourapikey> -t netflix .'
        //                 sh 'docker tag netflix nasi101/netflix:latest '
        //                 sh 'docker push nasi101/netflix:latest '
        //             }
        //         }
        //     }
        // }
        // stage('Deploy to container'){
        //     steps{
        //         sh 'docker run -d --name netflix -p 8081:80 nasi101/netflix:latest'
        //     }
        // }
    }
}
