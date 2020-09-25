pipeline {
    environment {
                registry = "ukkb96/myapp"
                registryCredential = 'dockerhub'
                dockerImage = ''
    }
     agent { label 'master' }
        stages {
          stage('cloning github repository') {
             steps {checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'github', url: 'https://github.com/ukkiran/simple-java-maven-app.git']]])
             }
          }
         stage('maven Build') {
            steps {
                withMaven(maven:'jenkinsmaven'){
                    sh 'mvn clean package'
                }
            }
         }
         stage('Test') {
            steps {
                withMaven(maven:'jenkinsmaven'){
                sh 'mvn test'
                }
            }
            post {
                always {
                    withMaven(maven:'jenkinsmaven'){
                    junit 'target/surefire-reports/*.xml'
                    }
                }
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
                       sh 'docker push ukkb96/myapp":$BUILD_NUMBER"'
                    }
                }
            }
         }
    }
}
