@Library('shared-libraries') _
def config = [name: 'Newman', dayOfWeek: 'Friday']

pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    agent any
    stages {
        stage('Code Compilation') {
            steps {
                	CompileCode(config)
            }
        }
	stage('Build Docker Image') {
           steps {
              		BuildDockerImage()
           }
         }
        stage('Upload Docker Image to AWS ECR') {
            steps {
			UploadDockerImageToECR()
		}
        }
        stage('Deploy') {
            steps {
                sh 'date'
	    }
        }
    }
}
