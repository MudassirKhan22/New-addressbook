pipeline{
       agent none

     tools {
        maven "mymaven"
    }

    environment{
        PACKAGE_SERVER_IP= 'ec2-user@13.233.19.123'
        IMAGE_NAME= 'mudassir12/New-addressbook'
    }

    parameters{
        string(name: 'Env', defaultValue: 'Test', description: 'Env to Deploy')
        booleanParam(name:'ExecuteTest', defaultValue: true, description:'Decide to run test cases')
        choice(name: 'Appversion', choices: ['1.1','1.2','1.3'], description: 'Select the version')
    }

    stages{
        stage('Compile'){
            agent any
            steps{
                echo "Environment to deploy:${params.Env}"
                echo "Compiling the code"
                git 'https://github.com/MudassirKhan22/New-addressbook.git'
                sh 'mvn compile'
            }
        }

        stage('UnitTest'){
            agent any
            when{
                expression{
                    params.ExecuteTest==true
                }
            }
            steps{
                echo "Testing the code"
                sh 'mvn test'
            }

            post{
                always{
                    junit 'target/surefire-reports/*.xml'
                }
            }  
        }

        stage('Package+Build the docker file+Push docker image to registry'){
            agent any
            steps{
                script{
                    sshagent(['my-slave-private-key']){
                        withCredentials([usernamePassword(credentialsId: 'DockerHub-Credentilas', passwordVariable: 'PASSWORD', usernameVariable: 'USERNAME')]) {
    
                        sh "scp -o strictHostKeyChecking=no server-config.sh ${PACKAGE_SERVER_IP}:/home/ec2-user"
                        sh "ssh -o strictHostKeyChecking=no ${PACKAGE_SERVER_IP} sudo bash /home/ec2-user/server-config.sh"
                        sh "ssh -o strictHostKeyChecking=no ${PACKAGE_SERVER_IP} sudo docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} /home/ec2-user/New-addressbook"
                        sh "ssh -o strictHostKeyChecking=no ${PACKAGE_SERVER_IP} sudo docker login -u ${USERNAME} -p ${PASSWORD}"
                        sh "ssh -o strictHostKeyChecking=no ${PACKAGE_SERVER_IP} sudo docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                        }
                    }
                }  
            }
        }

    }
}