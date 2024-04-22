pipeline 
{
    agent { label 'dev' }
    environment
    {
        docker = credentials('dockerhubcred')
    }
    

    stages
    {
        stage('scm git')
        {
            steps 
            {
                git 'https://github.com/tejagorrepati47/dicet_tv.git'
            }
            
        }
        stage('maven package')
        {
            steps 
            {
              sh '''mvn clean verify sonar:sonar  -Dsonar.projectKey=project1  -Dsonar.host.url=http://16.170.155.1:9000  -Dsonar.login=sqp_e30c6bdcd4056da1a4013702d703f5994b4d004a'''
            }
            
        }
         stage('dockercred')
        {
            steps 
            {
                  // This step should not normally be used in your script. Consult the inline help for details.
                   withDockerRegistry(credentialsId: 'dockerhubcred', url: 'https://index.docker.io/v1/') 
                   {
                      sh 'docker build -t gorrepatiteja/new-project2 .'
                      sh 'docker push gorrepatiteja/new-project2'
                    }
            }
              steps 
            {
                sh '''terraform init
                      terraform plan
                      terraform apply'''
            }
        }
    }
}

