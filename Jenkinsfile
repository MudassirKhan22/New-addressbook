pipeline{
    agent none

     tools {
        maven "mymaven"
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
        }

        stage('Package'){
            agent any
            steps{
                script{
                    sshagent(['my-slave-private-key']){
                    echo "Packing the code"
                    sh 'mvn package'
                    echo "Deploying app version:${params.Appversion}"
                    }
                }  
            }
        }

    }
}