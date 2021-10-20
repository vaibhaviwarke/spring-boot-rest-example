@Library('shared-libraries') _


pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    agent any
    stages {
        stage('Code Compilation') {
            steps {
		    script{
		    	sharedlibrary.CompileCode()
		    }
                	
            }
        }
	stage('Build Docker Image') {
           steps {
		   script{
		    	sharedlibrary.BuildDockerImage()
		    }
              		
           }
         }
        stage('Upload Docker Image to AWS ECR') {
            steps {
		    script{
		    	sharedlibrary.UploadDockerImageToECR()
		    }
			
		}
        }
        stage('Deploy') {
            steps {
                sh 'date'
	    }
        }
    }
}
