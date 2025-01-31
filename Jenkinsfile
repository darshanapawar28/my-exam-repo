pipeline{
    agent any
	environment {
        AWS_REGION = 'ap-south-1'
        S3_BUCKET = '467.devops.candi'
        TF_STATE_KEY = 'darshanapawar.tfstate'
}
    stages{
        stage("TF Init"){
            steps{
		script{
                	sh '''
		echo "Executing Terraform Init"

		terraform init -backend-config="bucket=${S3_BUCKET}" -backend-config="key=${TF_STATE_KEY}" -backend-config="region=${AWS_REGION}"
		'''
		}
            }
        }
        stage("TF Validate"){
            steps{
		script {
			sh '''
                    echo "Validating Terraform Code"
                    terraform validate
                    '''
			}
		}
	}
        stage("TF Plan"){
            steps{
		script{
			sh'''
                echo "Executing Terraform Plan"
		terraform plan
		'''
		}				
            }
        }
        stage("TF Apply"){
            steps{
		script {
			sh '''
                echo "Executing Terraform Apply"
		terraform apply -auto-approve
		'''
		}
            }
        }
        stage("Invoke Lambda"){
            steps{
		script {
			sh '''
                	echo "Invoking your AWS Lambda"
			aws lambda invoke --function-name devops-exam-lambda --payload '{"subnet_id": "subnet-12345678"}' --log-type Tail lambda_response.json
			cat lambda_response.json			
	            		}
        		}
    		}
	}
}
