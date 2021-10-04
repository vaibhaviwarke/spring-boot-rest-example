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
        stage('Build Docker Image') {
           steps {
		   whoami
                sh 'docker build -t java-project .'
           }
         }
        stage('Upload Docker Image to AWS ECR') {
            steps {
			   script {
			      withDockerRegistry([credentialsId:'ecr:ap-south-1:java-project-ecr', url:"357942556956.dkr.ecr.ap-south-1.amazonaws.com"]){
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
