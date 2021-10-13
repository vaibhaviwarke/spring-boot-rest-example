pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    agent any
    stages {
        stage('Code Compilation') {
            steps {
                sh 'mvn clean install'
		    sh 'ls'
		sh 'aws s3 cp /target/spring-boot-rest-example-0.5.0.war s3://spring-boot-war/spring-boot-rest-example-0.5.0.war'
            }
        }
	stage('Build Docker Image') {
           steps {
                sh """
		aws --region ap-south-1 ecr get-login-password | docker login --username AWS --password-stdin 357942556956.dkr.ecr.ap-south-1.amazonaws.com
		docker build -t java-project .
		"""
           }
         }
        stage('Upload Docker Image to AWS ECR') {
            steps {
		sh """
		echo "Tagging the Docker Image: In Progress"
		docker tag java-project:latest 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:latest
		echo "Tagging the Docker Image: Completed"
		echo "Push Docker Image to ECR : In Progress"
		docker push 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:latest
		echo "Push Docker Image to ECR : Completed"
                """
		}
        }
        stage('Deploy to Production') {
            steps {
                sh 'date'
	    }
        }
    }
}
