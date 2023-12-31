/* groovylint-disable CatchException, CompileStatic, DuplicateStringLiteral, NestedBlockDepth, NoDef, VariableTypeRequired */
pipeline {
    agent any
    // tools {
    //     maven 'MavenVersion'
    //     dockerTool 'dockerInstall'
    // }
    environment {
        HOLA_VARIABLE = 'hola ESTO ES UNA VARIABLE'
    }
    stages {
        stage('build') {
            steps {
                script {
                    echo 'Build'
                // sh 'python3 --version'
                // sh 'python3 python/python.py'
                }
            }
        }
        stage('test') {
            steps {
                script {
                    echo 'Testing'
                    // sh 'mvn clean'
                    println 'Testing from println PROBANDO'
                }
            }
        }
        stage('deploy') {
            steps {
                script {
                    echo 'Deploy con el moodo script de pipeline'
                // sh 'mvn -B package'
                    echo 'haciendo un cambio'
                    echo 'Agregando un cambio'
                }
            }
        }
        stage('sonarqube') {
            steps {
                echo 'Entrando a Sonarqube'
                echo 'Probando una nueva linea'
                script {
                    def scannerHome = tool 'sonarscanner'
                    withCredentials([string(credentialsId: 'sonartoken', variable: 'SONARTOKEN')]) {
                        withSonarQubeEnv(installationName: 'sonarserver') {
                            sh """
                        ${scannerHome}/bin/sonar-scanner \\
                        -Dsonar.projectName=jenkins-sonar-fromjenkinsfile \\
                        -Dsonar.projectKey=sonartoken \\
                        -Dsonar.projectVersion=1.3 \\
                        -Dsonar.sources=src/main/java/ \\
                        -Dsonar.language=java \\
                        -Dsonar.java.binaries=./target/classes \\
                        -Dsonar.host.url=http://192.168.118.128:9000 \\
                        -Dsonar.login=${SONARTOKEN}
                    """
                        }
                    }
                }
            }
        }
        stage('Quality Gate') {
            steps {
                script {
                    timeout(time: 1, unit: 'HOURS') {
                        def qg = waitForQualityGate(abortPipeline: true, webhookSecretId: 'qualitygatewebhook')
                        if (qg.status != 'OK') {
                            error "Pipeline aborted due to quality gate failure: ${qg.status}"
                        }
                    }
                }
            }
        }
        stage('SonarType Nexus') {
            steps {
                script {
                    if (!fileExists('pom.xml')) {
                        error('El archivo pom.xml no existe')
                    }
                    pom = readMavenPom file: 'pom.xml'
                    filesByGlob = findFiles(glob: "target/*.${pom.packaging}")
                    if (filesByGlob.length == 0) {
                        error("No se encontraron archivos que coincidan con el patrón target/*.${pom.packaging}")
                    }
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path
                    artifactExists = fileExists artifactPath
                    if (artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}"
                        try {
                            nexusArtifactUploader(
                                nexusVersion: 'nexus3',
                                protocol: 'http',
                                nexusUrl: '192.168.118.128:8081',
                                groupId: pom.groupId,
                                version: pom.version,
                                repository: 'mavenSnapshotHosted',
                                credentialsId: 'adminNexus',
                                artifacts: [
                                    [artifactId: pom.artifactId,
                                            classifier: '',
                                            file: artifactPath,
                                            type: pom.packaging]
                                ]
                            )
                        } catch (Exception e) {
                            error("No se pudo conectar a Nexus: ${e.message}")
                        }
                    } else {
                        error("*** File: ${artifactPath}, could not be found")
                    }
                }
            }
        }
        stage('SoapUi Test Runner') {
            steps {
                script {
                    println 'Probando SoapUi'
                    // sh 'mvn clean'
                    if (!fileExists('Dockerfile')) {
                        error('El archivo Dockerfile no existe')
                    }
                    // Define las rutas de los archivos, tests y reportes

                    // def imageRunner = 'smartbear/soapuios-testrunner'
                    // def soapUiProjectFile = 'REST-Project-2-soapui-project.xml'
                    // def soapUiProjectDir = '/home/dev/courses/devops/files/jenkins/soapUi/project'
                    // def soapUiReportDir = '/home/dev/courses/devops/files/jenkins/soapUi/report'

                    // sh """
                    // docker run -v ${soapUiProjectDir}:/project -v ${soapUiReportDir}:/reports -e COMMAND_LINE="-r -a -j -J -f/%reports% '/%project%/${soapUiProjectFile}'" ${imageRunner}
                    //  """
                    // sh """
                    //   docker run -v /home/dev/courses/devops/projects/mod-3/nexus-sonar-jenkins/testSoapRunner:/project -v /home/dev/courses/devops/projects/mod-3/nexus-sonar-jenkins/testSoapRunner/reports:/reports -e COMMAND_LINE="-r -a -j -J -f/%reports% '/%project%/REST-Project-2-soapui-project.xml'" smartbear/soapuios-testrunner
                    // """

                    // sh "docker build -t soaprunner:${env.BUILD_TAG} ."
                    // def result = sh "docker run -v ${WORKSPACE}/${soapUiProjectDir}:/tests -v ${WORKSPACE}/${soapUiReportDir}:/reports soaprunner:${env.BUILD_TAG} testrunner.sh -sTestSuite -cTestCase -r -a -j -J -f/reports /tests/${soapUiProjectFile}"

                // def customImage = docker.build("soaprunner:${env.BUILD_TAG}", '.')
                // customImage.inside('-v ${WORKSPACE}/soapUi/test:/tests -v ${WORKSPACE}/soapUi/report:/reports') {
                //     sh "testrunner.sh -sTestSuite -cTestCase -r -a -j -J -f/reports /tests/${soapUiProjectFile}"
                // }
                }
            }
        }
        stage('Jmeter') {
            steps {
                script {
                    println 'Probando Jmeter'
                }
            }
        }
        stage('Terraform') {
            steps {
                script {
                    println 'Probando Terraform'
                }
            }
        }
    }
// post {
//     always {
//         script {
//             echo 'Always Post'
//             junit(
//         allowEmptyResults: true,
//         testResults: 'target/surefire-reports/*.xml, target/failsafe-reports/*.xml')
//             slackSend(color: 'good', channel: '#pruebas-de-devops', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
//         }
//     }
// }
}
