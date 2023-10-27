pipeline{
    agent any

     tools {
        jdk "myjava"
        maven "mymaven"
    }

      environment {
        JAVA_HOME = tool name: 'myjava', type: 'hudson.model.JDK'
        PATH = "${env.JAVA_HOME}/bin:$PATH"
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