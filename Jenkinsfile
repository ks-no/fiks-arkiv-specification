pipeline {
    agent any
    stages {
        stage ("build") {
            steps {
                build job: '/KS/fiks-arkiv-client-java/main'
            }
        }
        stage ('dotnet') {
          steps {
            build job: '/KS/fiks-arkiv-models-dotnet/main', parameters: [[$class: 'StringParameterValue', name:'triggerbranch', value: env.BRANCH_NAME]]
          }
        }
    }
}