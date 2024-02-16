pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Checkout the code from Git
                git 'https://github.com/yourusername/yourrepository.git'

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
    // stage('Deploy') {
    //     steps {
    //         // Deploy the artifact (e.g., to JFrog)
    //         // Replace 'yourartifact.jar' with the name of your artifact
    //         // and 'your-repository' with your repository name in JFrog
    //         sh 'curl -u yourusername:yourpassword -T target/yourartifact.jar "https://yourdomain.jfrog.io/your-repository/yourartifact.jar"'
    //     }
    // }
    }
}
