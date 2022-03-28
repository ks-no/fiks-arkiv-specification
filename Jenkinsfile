pipeline {
    agent any
    stages {
        stage ("build") {
            steps {
                build job: '/KS/fiks-arkiv-client-java/main'
            }
        }
        stage ('dotnet') {
          when {
            branch 'main'
          }
          steps {
            build job: '/KS/fiks-arkiv-models-dotnet/main'
          }
        }
    }
}