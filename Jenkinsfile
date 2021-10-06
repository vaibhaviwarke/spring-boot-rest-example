pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }
    agent any
    stages {
        stage('Code Compilation') {
            steps {
                sh 'mvn clean package'
            }
        }
        stage('Upload Docker Image to AWS ECR') {
            steps {
			   script {
			      docker.withRegistry('357942556956.dkr.ecr.ap-south-1.amazonaws.com', 'ecr:ap-south-1:357942556956'){
                  sh """
				  echo "Tagging the Docker Image: In Progress"
				  docker tag java-project:latest 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:1.0.1
				  echo "Tagging the Docker Image: Completed"
				  echo "Push Docker Image to ECR : In Progress"
				  docker push 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:1.0.1
				  echo "Push Docker Image to ECR : Completed"
				  """
				  }
                }
            }
		}
        stage('Deploy to Production') {
            steps {
                sh 'date'
            }
        }
    }
}
