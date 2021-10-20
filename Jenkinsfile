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
		    	shared-library.CompileCode()
		    }
                	
            }
        }
	stage('Build Docker Image') {
           steps {
		   script{
		    	shared-library.BuildDockerImage()
		    }
              		
           }
         }
        stage('Upload Docker Image to AWS ECR') {
            steps {
		    script{
		    	shared-library.UploadDockerImageToECR()
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
