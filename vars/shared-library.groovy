def CompileCode() {
    	sh "mvn clean install"
}

def BuildDockerImage() {
    	sh """
		aws --region ap-south-1 ecr get-login-password | docker login --username AWS --password-stdin 357942556956.dkr.ecr.ap-south-1.amazonaws.com
    		docker build -t java-project .
	"""
}

def UploadDockerImageToECR(){
	sh """
		echo "Tagging the Docker Image: In Progress"
		docker tag java-project:latest 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:latest
		echo "Tagging the Docker Image: Completed"
		echo "Push Docker Image to ECR : In Progress"
		docker push 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:latest
		echo "Push Docker Image to ECR : Completed"
          """
}

