// pipeline {
//     agent any
//     tools {
//         jdk 'jdk17'
//         maven 'maven'
//     }
//     environment {
//         SCANNER_HOME = tool 'SonarScanner'
//     }
//     stages {
//         stage('clean workspace') {
//             steps {
//                 cleanWs()
//             }
//         }
//         stage('Checkout from Git') {
//             steps {
//                 git branch: 'main', url: 'https://github.com/Sivaram0/spring-framework-petclinic.git'
//             }
//         }
//         stage('Maven') {
//             steps {
//                 tool 'maven'
//                 sh 'mvn clean package'
//             }
//         }
//         stage('SonarQube Analysis') {
//             steps {
//                 withSonarQubeEnv('sonar-server') {
//                     sh "${SCANNER_HOME}/bin/sonar-scanner \
//                         -Dsonar.projectName=spring-framework-petclinic \
//                         -Dsonar.projectKey=spring-framework-petclinic \
//                         -Dsonar.sources=src/main/java \
//                         -Dsonar.java.binaries=target/classes"
//                 }
//             }
//         }
//         // stage('archive the artifacts') {
//         //     archiveArtifacts archive: 'target/*.jar', onlyIfSuccessful: true
//         // }
//         stage('build and package') {
//             steps {
//                  rtMavenDeployer (
//                     id: "SPC_DEPLOYER",
//                     serverId: "JFROG_CLOUD",
//                     releaseRepo: 'qt-app-libs-snapshot-local',
//                     snapshotRepo: 'qt-app-libs-snapshot-local'
//                 )
//                 rtMavenRun (
//                     tool: 'MAVEN_3.9', // Tool name from Jenkins configuration
//                     pom: 'pom.xml',
//                     goals: 'clean install',
//                     deployerId: "SPC_DEPLOYER"
//                 )
//                 rtPublishBuildInfo (
//                     serverId: "JFROG_CLOUD"
//                 )
//             }
//         }
//         stage('reporting') {
//             steps {
//                 junit testResults: '**/target/surefire-reports/TEST-*.xml'
//             }
//         }
//         stage('Docker Build & Push') {
//             steps {
//                 script {
//                     withDockerRegistry(credentialsId: 'docker', toolName: 'docker') {
//                         sh 'docker build -t springpetclinic .'
//                         sh 'docker tag springpetclinic sivaramaprasad/springpetclinic:latest '
//                         sh 'docker push sivaramaprasad/springpetclinic:latest '
//                     }
//                 }
//             }
//         }
//         stage('TRIVY') {
//             steps {
//                 sh 'trivy image sivaramaprasad/springpetclinic:latest > trivyimage.txt'
//             }
//         }
//         stage('Deploy to container') {
//             steps {
//                 sh 'docker run -d --name spring -p 8081:80 springpetclinic:latest'
//             }
//         }
//     }
// }
