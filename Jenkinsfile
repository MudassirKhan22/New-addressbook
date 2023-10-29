pipeline{
    agent none

     tools {
        maven "mymaven"
    }

    environment{
        PACKAGE_SERVER_IP= 'ec2-user@3.111.42.71'
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

        stage('Package'){
            agent any
            steps{
                script{
                    sshagent(['my-slave-private-key']){
                    echo "Packing the code"
                    sh "scp -o strictHostKeyChecking=no server-config.sh ${PACKAGE_SERVER_IP}:/home/ec2-user"
                    sh "ssh -o strictHostKeyChecking=no ${PACKAGE_SERVER_IP} bash '/home/ec2-user/server-config.sh' "
                    echo "Deploying app version:${params.Appversion}"
                    }
                }  
            }
        }

    }
}