pipeline {
    agent any
    environment {
        //Replace "gg2019" with your own Docker Hub username
        DOCKER_IMAGE_NAME = "gg2019/hello-world"
    }
    stages {
        stage('Build Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                    //app.inside {
                    //    sh 'echo Hello, World!'
                    //}
                }
            }
        }
        stage('Push Docker Image') {
            when {
                branch 'master'
            }
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
                
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                //input 'Deploy to Production?'
                //milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'helloworld-kube.yml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}
