/* groovylint-disable CompileStatic, NestedBlockDepth, NoDef, VariableTypeRequired */
pipeline {
    agent any
    environment {
        HOLA_VARIABLE = 'hola ESTO ES UNA VARIABLE'
    }
    stages {
        stage('build') {
            steps {
                script {
                    echo 'Build'
                    sh 'python3 --version'
                    sh 'python3 python.py'
                }
            }
        }

        stage('test') {
            steps {
                script {
                    echo 'Testing'
                    sh 'mvn clean'
                    println 'Testing from println PROBANDO'
                }
            }
        }

        stage('deploy') {
            steps {
                script {
                    echo 'Deploy con el moodo script de pipeline'
                    sh 'mvn -B package'
                    sh 'mvn verify'
                }
            }
        }

        stage('sonarqube') {
            steps {
                echo 'Entrando a Sonarqube'
                script {
                    def scannerHome = tool 'SonarQubeScanner'
                    withCredentials([string(credentialsId: 'sonarqube-login-token', variable: 'SONARQUBE_LOGIN_TOKEN')]) {
                        withSonarQubeEnv(installationName: 'SonarQubeServer') {
                            sh """
                        ${scannerHome}/bin/sonar-scanner \\
                        -Dsonar.projectName=jenkins-sonar-fromjenkinsfile \\
                        -Dsonar.projectKey=sonartoken \\
                        -Dsonar.projectVersion=1.3 \\
                        -Dsonar.sources=src/main/java/ \\
                        -Dsonar.language=java \\
                        -Dsonar.java.binaries=./target/classes \\
                        -Dsonar.host.url=http://172.28.112.1:9000 \\
                        -Dsonar.login=${SONARQUBE_LOGIN_TOKEN}
                    """
                        }
                    }
                }
            }
        }
        // stage('Quality Gate') {
        //     steps {
        //         script {
        //             timeout(time: 1, unit: 'HOURS') {
        //                 def qg = waitForQualityGate(abortPipeline: true, webhookSecretId: 'qualitygatewebhook')
        //                 if (qg.status != 'OK') {
        //                     error "Pipeline aborted due to quality gate failure: ${qg.status}"
        //                 }
        //             }
        //         }
        //     }
        // }
        stage('SonarType Nexus') {
            steps {
                script {
                    pom = readMavenPom file: 'pom.xml'
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}")
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path
                    artifactExists = fileExists artifactPath
                    if (artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}"
                        nexusArtifactUploader(
                    nexusVersion: 'nexus3',
                    protocol: 'http',
                    nexusUrl: 'localhost:8081',
                    groupId: pom.groupId,
                    version: pom.version,
                    repository: 'MavenHosted',
                    credentialsId: 'adminNexuss',
                    artifacts: [
                        [artifactId: pom.artifactId,
                                classifier: '',
                                file: artifactPath,
                                type: pom.packaging]
                    ]
                )
            } else {
                        error "*** File: ${artifactPath}, could not be found"
                    }
                }
            }
        }
    }
}
