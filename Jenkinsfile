#!/usr/bin/groovy

def call(body) {
    config = [:]

    if (body != null) {
        body.resolveStrategy = Closure.DELEGATE_FIRST
        body.delegate = config
        body()
    }

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
          booleanParam(name: 'pushToNugetOrg', defaultValue: false, description: 'Skal artifaktet pushes til nuget.org? Kun relevant for pre-release bygg da release alltid pushes dit')
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
                    } else {
                      def timestamp = getTimestamp()
                      env.VERSION_SUFFIX = "build.${timestamp}"
                      env.BUILD_SUFFIX = "--version-suffix ${env.VERSION_SUFFIX}"
                      env.FULL_VERSION = "${CURRENT_VERSION}-${env.VERSION_SUFFIX}"
                    }
                    
                    sh 'printenv'
                }
                println("repo: ${env.REPO_NAME}, config: ${config}")
              }
            }

            stage('Build') {
              parallel { 
                stage('Dotnet build - linux') {
                  environment {
                    NUGET_HTTP_CACHE_PATH = "${env.WORKSPACE + '@tmp/cache'}"
                    NUGET_CONF = credentials('nuget-config')
                  }
                  agent {
                    docker {
                      image "docker-all.artifactory.fiks.ks.no/dotnet/sdk:5.0"
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
                        sh 'dotnet build --no-restore -c Debug $BUILD_SUFFIX && dotnet build --no-restore -c Release $BUILD_SUFFIX'
                      }
                      post {
                        success {
                          recordIssues enabledForFailure: true, tools: [msBuild()]
                        }
                      }
                    }
                    stage('Run tests') {
                      steps {
                        sh 'dotnet test --no-build --verbosity normal --logger "trx;LogFileName=results.trx"'
                      }
                      post {
                        success {
                            xunit(  thresholds: [ skipped(failureThreshold: '10'), failed(failureThreshold: '0') ],
                                    tools: [ MSTest(pattern: '**/*.trx', stopProcessingIfError: false, skipNoTestFiles: true) ])
                            stash(name: 'docker-build-nuget', includes: '**/Release/*.nupkg')

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
                stage("Dotnet build - windows") {
                  agent {
                    label 'windows'
                  }
                  environment {
                    CODE_SIGN_CERT = credentials('ks-codesign-combo')
                    CODE_SIGN_KEY = credentials('ks-codesign-combo-passwd')
                    TIMESTAMP_URL = 'http://timestamp.digicert.com'
                    NUGET_ACCESS_KEY = credentials('artifactory-token-based')
                    NUGET_PUSH_REPO = 'https://artifactory.fiks.ks.no/artifactory/api/nuget/nuget-all'
                    NUGET_CONF = credentials('nuget-config')        
                    TMPDIR = "${env.PWD + '\\tmpdir'}"
                    MSBUILDDEBUGPATH = "${env.TMPDIR}"            
                  }
                  stages {
                  
                    stage('Build') {
                      steps {
                        powershell script: 'New-Item -ItemType Directory -Force -Path $env:TMPDIR | Out-Null', label: 'Create tempdir'
                        bat script: 'dotnet restore --configfile %NUGET_CONF% --disable-parallel --verbosity detailed', label: 'Restore dependencies'
                        bat script: 'dotnet build --no-restore -c Debug %BUILD_SUFFIX% ', label: 'Build using Debug profile on Windows'
                        bat script: 'dotnet build --no-restore -c Release %BUILD_SUFFIX%', label: 'Build using Release profile on Windows'
                      }
                      post {
                        failure {
                          archiveArtifacts artifacts: "${env.MSBUILDDEBUGPATH}\\MSBuild_*.failure.txt", fingerprint: true, allowEmptyArchive: true
                        }

                      }
                    }
                    stage('Run tests') {
                      steps {
                        powershell script: 'dotnet test --no-build --verbosity detailed --logger "trx;LogFileName=results.trx"', label: "Runs all unit tests"
                      }
                      post {
                        success {
                            mstest testResultsFile:"**/*.trx", keepLongStdio: true, failOnError: true
                        }
                      }
                    }
                    stage('Sign package') {
                      steps {
                        powershell script: 'nuget sign */**/Release/*.nupkg -Timestamper $env:TIMESTAMP_URL -CertificatePath $env:CODE_SIGN_CERT -CertificatePassword $env:CODE_SIGN_KEY', label: "Sign artifact with the KS certificate"
                      }
                      post {
                        success {
                          archiveArtifacts artifacts: '*/**/Release/*.nupkg', fingerprint: true
                          stash(name: 'windows-build-nuget', includes: '**/Release/*.nupkg')
                          stash(name: 'windows-build-nuget-symbols', includes: '**/Release/*.snupkg', allowEmpty: true)
                        }
                      }
                    }
                    stage('Push to Artifactory') {
                      steps {
                          powershell script: 'dotnet nuget push */**/Release/*.nupkg -k $env:NUGET_ACCESS_KEY -s $env:NUGET_PUSH_REPO', label: 'Push artifact(s) to Artifactory'
                      }                      
                    }
                  }
                  post {
                    always {
                      deleteDir()
                    }
                  }
                }
              }
            }
            stage('Get component version') {
              steps {
                unstash(name: 'docker-build-nuget')
                script {
                  config.COMPONENT_VERSION = env.FULL_VERSION                
                  println("Component version: ${config.COMPONENT_VERSION}")
                }
                  
              }

            }
            stage('Run component tests') {
              when {
                  expression { config.componentTestProject }
              }
              steps {
                sleep 10
                runComponentTests() 
              }
            }
            stage('Push to nuget.org') {
              when {
                anyOf {
                  expression { params.isRelease }
                  expression { params.pushToNugetOrg }
                }
                beforeAgent true
              }

              agent {
                label 'windows'
              }
              environment {
                NUGET_ACCESS_KEY = credentials('ks-nuget-api-key')
                NUGET_PUSH_REPO = 'https://api.nuget.org/v3/index.json'
              }
              steps {
                unstash(name: 'windows-build-nuget')
                unstash(name: 'windows-build-nuget-symbols')
                bat 'dotnet nuget push */**/Release/*.nupkg -k %NUGET_ACCESS_KEY% -s %NUGET_PUSH_REPO%'
              }
              post {
                success {
                  deleteDir()
                }
              }
            }
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
}
def findVersionSuffix() {
  def findCommand = $/find -name "*.csproj" -exec xpath '{}' '/Project/PropertyGroup/VersionPrefix/text()' \;/$

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

def runComponentTests() {
    build job: "/KS/${config.componentTestProject}/master", propagate: true, wait: true, parameters:[[$class: 'StringParameterValue', name: 'componentVersion', value:config.COMPONENT_VERSION]]
}



