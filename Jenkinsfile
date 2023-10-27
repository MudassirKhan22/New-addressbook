pipeline{
    agent any

     tools {
        maven "mymaven"
    }



    stages{
        stage('Compile'){
            steps{
                echo "Compiling the code"
                git 'https://github.com/MudassirKhan22/New-addressbook.git'
                sh 'mvn compile'
            }
        }

        stage('UnitTest'){
            steps{
                echo "Testing the code"
                sh 'mvn test'
            }
        }

        stage('Package'){
            steps{
                echo "Packing the code"
                sh 'mvn package'
            }
        }

    }
}