pipeline {
    
    agent any 
    
    environment {
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: '4adc74be-f9bb-49e7-b0be-a2f88f32c31a', 
                url: 'https://github.com/dgopichand/cicd-end-to-end',
                branch: 'main'
           }
        }

        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    docker build -t dgopichand/cicd-e2e:v${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    sh '''
                    echo 'Push to Repo'
                    docker push dgopichand/cicd-e2e:v${BUILD_NUMBER}
                    '''
                }
            }
        }
        
        stage('Checkout K8S manifest SCM'){
            steps {
                git credentialsId: '4adc74be-f9bb-49e7-b0be-a2f88f32c31a', 
                url: 'https://github.com/dgopichand/cicd-e2e-manifest-files.git',
                branch: 'main'
            }
        }
        
        stage('Update K8S manifest & push to Repo'){
            steps {
                script{
                    withCredentials([usernamePassword(credentialsId: '4adc74be-f9bb-49e7-b0be-a2f88f32c31a', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh '''
                        cd argocd
                        
                        # Check the content before updating
                        cat deploy.yaml
                        
                        # Update the deployment file version
                        sed -i "s/v1/v${BUILD_NUMBER}/g" deploy.yaml

                        # Display the updated content
                        cat deploy.yaml

                        # Commit and push changes
                        git add deploy.yaml
                        git commit -m 'Updated the deploy yaml | Jenkins Pipeline'
                        git remote -v
                        git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/dgopichand/cicd-e2e-manifest-files.git HEAD:main
                        '''                        
                    }
                }
            }
        }
    }
}
