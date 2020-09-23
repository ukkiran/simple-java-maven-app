pipeline {
    node master {
        stages {
         stage('init') {
             steps {
             checkout scm
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
       app = docker.build("ukkb96/myapp") 
    }

    stage('push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'DOCKERHUB') {
            app.push("latest")
         }
    }
    stage('analysing code with sonarqube') {
      sh 'mvn clean package sonar:sonar'
    }  
  }
}
}
