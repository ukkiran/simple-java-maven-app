pipeline {
    environment {
                registry = "ukkb96/myapp"
                registryCredential = 'dockerhub'
                dockerImage = ''
    }
     agent { label 'master' }
        stages {
          stage('cloning github repository') {
             steps {
               sh 'git clone https://github.com/ukkiran/simple-java-maven-app.git'
             }
          }
         stage('Build') {
            steps {
                sh 'mvn clean package'
            }
         }
         stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/surefire-reports/*.xml'
                }
            }
         }
         stage('Deliver') {
            steps {
                sh './jenkins/scripts/deliver.sh'
            }
         }
    
         stage('Build image') {
            steps{
                script {
                     docker.build registry + ":$BUILD_NUMBER"
                }
            }
         }

         stage('push image') {
            steps{
                script{
                    docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()}
                }
            }
         }
         stage('analysing code with sonarqube'){
            steps{
                sh 'mvn clean package sonar:sonar'
            }  
         }
    }
}
