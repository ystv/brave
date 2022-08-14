String registryEndpoint = 'registry.comp.ystv.co.uk'

def image
String imageName = "brave:${env.BRANCH_NAME}-${env.BUILD_ID}"

// Checking if it is semantic version release.
String deployEnv = env.TAG_NAME ==~ /v(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)/ ? 'prod' : 'dev'

pipeline {
  agent {
    label 'docker'
  }

  stages {
    stage('Build image') {
      steps {
        script {
          image = docker.build(imageName)
        }
      }
    }

    stage('Push image to registry') {
      steps {
        script {
          docker.withRegistry('https://' + registryEndpoint, 'docker-registry') {
            image.push()
            if (env.BRANCH_IS_PRIMARY) {
              image.push('latest')
            }
          }
        }
      }
    }

    stage('Deploy') {
      when {
        anyOf {
          expression { env.BRANCH_IS_PRIMARY }
          equals(actual: deployEnv, expected: 'prod')
        }
      }

      steps {
        build(job: 'Deploy Nomad Job', parameters: [
          string(name: 'JOB_FILE', value: "brave-${deployEnv}.nomad"),
          text(name: 'TAG_REPLACEMENTS', value: "${registryEndpoint}/${imageName}")
        ])
      }
    }
  }
}
