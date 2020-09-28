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
         stage('build && SonarQube analysis') {
             steps{
                withSonarQubeEnv('sonarqube') {
                    // Optionally use a Maven environment you've configured already
                      withMaven(maven:'jenkinsmaven'){
                    sh 'mvn sonar:sonar \
                        -Dsonar.projectKey=simple-java-maven \
                        -Dsonar.host.url=http://localhost:9000 \
                        -Dsonar.login=6fe143da9b509eb5a180112bd8c571e7ccb0530c'
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
