#!/usr/bin/groovy

pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '50'))
    disableConcurrentBuilds()
    timeout(time: 60, unit: 'MINUTES')
    timestamps ()
  }
  agent any
  parameters {
    booleanParam(name: 'isRelease', defaultValue: false, description: 'Skal prosjektet releases? Alle andre parametere ignoreres ved snapshot-bygg.')
    string(name: "specifiedVersion", defaultValue: "", description: "Hva er det nye versjonsnummeret (X.X.X)? Som default releases snapshot-versjonen")
    text(name: "releaseNotes", defaultValue: "Ingen endringer utført", description: "Hva er endret i denne releasen?")
    text(name: "securityReview", defaultValue: "Endringene har ingen sikkerhetskonsekvenser", description: "Har endringene sikkerhetsmessige konsekvenser, og hvilke tiltak er i så fall iverksatt?")
    string(name: "reviewer", defaultValue: "Endringene krever ikke review", description: "Hvem har gjort review?")
  }
  stages {
    stage('Initialize') {
      steps {
        script {
            wrap([$class: 'BuildUser']) {
                env.user = sh ( script: 'echo "${BUILD_USER}"', returnStdout: true).trim()
            }
            env.GIT_SHA = sh(returnStdout: true, script: 'git rev-parse HEAD').substring(0, 7)
            env.REPO_NAME = scm.getUserRemoteConfigs()[0].getUrl().tokenize('/').last().split("\\.")[0]
            env.CURRENT_VERSION = findVersionSuffix()
            env.NEXT_VERSION = params.specifiedVersion == "" ? incrementVersion(env.CURRENT_VERSION) : params.specifiedVersion
            if(params.isRelease) {
              env.VERSION_SUFFIX = ""
              env.BUILD_SUFFIX = ""
              env.FULL_VERSION = env.CURRENT_VERSION
              env.Configuration = 'Release'
            } else {
              def timestamp = getTimestamp()
              env.VERSION_SUFFIX = "build.${timestamp}"
              env.BUILD_SUFFIX = "--version-suffix ${env.VERSION_SUFFIX}"
              env.FULL_VERSION = "${CURRENT_VERSION}-${env.VERSION_SUFFIX}"
              env.Configuration = 'Debug'
            }
            sh 'printenv'
        }
        println("repo: ${env.REPO_NAME}, config: ${config}")
      }
    }
    stage('Change directory'){
      steps{
        sh 'cd dotnet'
      }
    }
    stage('Copy xsd files'){
      steps {
        sh 'GenerateModels.sh'
      }
    }
    stage('Dotnet build - linux') {
      environment {
        NUGET_HTTP_CACHE_PATH = "${env.WORKSPACE + '@tmp/cache'}"
        NUGET_CONF = credentials('nuget-config')
        CODE_SIGN_CERT = credentials('ks-codesign-combo')
        CODE_SIGN_KEY = credentials('ks-codesign-combo-passwd')
        TIMESTAMP_URL = 'http://timestamp.digicert.com'
        NUGET_ACCESS_KEY = credentials('artifactory-token-based')
        NUGET_PUSH_REPO = 'https://artifactory.fiks.ks.no/artifactory/api/nuget/nuget-all'      
        TMPDIR = "${env.PWD + '\\tmpdir'}"
        MSBUILDDEBUGPATH = "${env.TMPDIR}"   
      }
      agent {
          docker {
            image "docker-all.artifactory.fiks.ks.no/dotnet/sdk:6.0"
            args '-v $HOME/.nuget:/.nuget -v $HOME/.dotnet:/.dotnet'
          }
      }
      stages {
        stage('Build') {
          steps {
            sh 'mkdir -p /.nuget/NuGet'
            sh 'cp -f $NUGET_CONF ~/.nuget/NuGet/NuGet.Config'
            sh 'dotnet --version'
            sh 'dotnet restore --verbosity detailed --configfile ${NUGET_CONF}'
            sh 'dotnet build --no-restore -c $Configuration $BUILD_SUFFIX'
          }
          post {
            success {
              recordIssues enabledForFailure: true, tools: [msBuild()]
            }
          }
        }
        stage('Sign package') {
          steps {
            sh 'nuget sign */**/$env:Configuration/*.nupkg -Timestamper $env:TIMESTAMP_URL -CertificatePath $env:CODE_SIGN_CERT -CertificatePassword $env:CODE_SIGN_KEY', label: "Sign artifact with the KS certificate"
          }
          post {
            success {
              archiveArtifacts artifacts: '*/**/$env:Configuration/*.nupkg', fingerprint: true
              stash(name: 'nuget', includes: '**/$env:Configuration/*.nupkg')
              stash(name: 'nuget-symbols', includes: '**/$env:Configuration/*.snupkg', allowEmpty: true)
            }
          }
        }
        stage('Push to Artifactory') {
          steps {
              sh 'dotnet nuget push */**/$Configuration*.nupkg -k $env:NUGET_ACCESS_KEY -s $env:NUGET_PUSH_REPO', label: 'Push artifact(s) to Artifactory'
          }                      
        }
      }
      post {
        always {
          deleteDir()
        }
      }
    }
    // stage('Push to nuget.org') {
    //   when {
    //     anyOf {
    //       expression { params.isRelease }
    //     }
    //     beforeAgent true
    //   }
    //   environment {
    //     NUGET_ACCESS_KEY = credentials('ks-nuget-api-key')
    //     NUGET_PUSH_REPO = 'https://api.nuget.org/v3/index.json'
    //   }
    //   steps {
    //     unstash(name: 'nuget')
    //     unstash(name: 'nuget-symbols')
    //     sh 'dotnet nuget push */**/$Configuration/*.nupkg -k $env:NUGET_ACCESS_KEY -s $env:NUGET_PUSH_REPO'
    //   }
    //   post {
    //     success {
    //       deleteDir()
    //     }
    //   }
    // }
    stage('Set next version and push') {
      when {
        allOf {
          expression { params.isRelease }
          expression { return env.NEXT_VERSION }
          expression { return env.CURRENT_VERSION }
        }
      }
      steps {
        gitCheckout(env.BRANCH_NAME)
        gitTag(isRelease, env.CURRENT_VERSION)
        prepareDotNetNoBuild(env.NEXT_VERSION)
        gitPush()
        script {
          currentBuild.description = "${env.user} released version ${env.CURRENT_VERSION}"
        }
        withCredentials([usernamePassword(credentialsId: 'Github-token-login', passwordVariable: 'GITHUB_KEY', usernameVariable: 'USERNAME')]) {
            sh "~/.local/bin/http --ignore-stdin -a ${USERNAME}:${GITHUB_KEY} POST https://api.github.com/repos/ks-no/${env.REPO_NAME}/releases tag_name=\"${env.CURRENT_VERSION}\" body=\"Release utført av ${env.user}\n\n## Endringer:\n${params.releaseNotes}\n\n ## Sikkerhetsvurdering: \n${params.securityReview} \n\n ## Review: \n${params.reviewer == 'Endringene krever ikke review' ? params.reviewer : "Review gjort av ${params.reviewer}"}\""
        }
      }
    }              
  }
  post {
    always {
      deleteDir()
    }
  }
}
def findVersionSuffix() {
  def findCommand = $/find -name "**\KS.FIks.Arkiv.Models.csproj" -exec xpath '{}' '/Project/PropertyGroup/VersionPrefix/text()' \;/$

  def version = sh(script: findCommand, returnStdout: true, label: 'Lookup current version from csproj files').trim().split('\n').find {
    return it.trim().matches(versionPattern())
  }
  println("Version found: ${version}")
  return version
}

def incrementVersion(versionString) {
    def p = versionPattern()
    def m = p.matcher(versionString)
    if(m.find()) {
        def major = m.group(1) as Integer
        def minor = m.group(2) as Integer
        def patch = m.group(3) as Integer
        return "${major}.${minor}.${++patch}"
    } else {
        return null
    }
}

def versionPattern() {
  return java.util.regex.Pattern.compile("^(\\d+)\\.(\\d+)\\.(\\d+)(.*)?")
}

def getTimestamp() {
  return java.time.OffsetDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyyMMddHHmmssSSS"))
}
