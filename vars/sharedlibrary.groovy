def CompileCode() {
    	sh "mvn clean install"
}

def BuildDockerImage() {
    	sh """
		`aws --region ap-south-1 ecr get-login --no-include-email`
		#aws --region ap-south-1 ecr get-login-password | docker login --username AWS --password-stdin 357942556956.dkr.ecr.ap-south-1.amazonaws.com
    		docker build -t java-project .
	"""
}

def UploadDockerImageToECR(){
	sh """
		docker tag java-project:latest 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:latest
		docker push 357942556956.dkr.ecr.ap-south-1.amazonaws.com/java-project:latest
          """
}

