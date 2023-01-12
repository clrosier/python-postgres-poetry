@Library('jenkins-psl')_

pipeline { 
    environment {
        IMAGE_NAME = "clrosier/python-postgres-poetry"
        REGISTRY_CREDENTIAL = credentials("dockerhub")
        IMAGE_VERSION = getImageVersion(env.GIT_BRANCH, "$BUILD_NUMBER")
    }
    agent {
        kubernetes {
            yaml '''
                apiVersion: v1
                kind: Pod
                spec:
                    containers:
                    - name: docker
                      image: docker:latest
                      command:
                      - cat
                      tty: true
                      volumeMounts:
                      - mountPath: /var/run/docker.sock
                        name: docker-sock
                    volumes:
                    - name: docker-sock
                      hostPath:
                        path: /var/run/docker.sock
                '''
        }
    }
    stages {
        stage("Build Image") {
            steps {
                container('docker') {
                    sh "docker build -t ${IMAGE_NAME}:${IMAGE_VERSION} -t ${IMAGE_NAME}:latest ."
                }
            }
        }
        stage("Push Image") {
            steps {
                container('docker') {
                    sh "docker login -u ${REGISTRY_CREDENTIAL_USR} -p ${REGISTRY_CREDENTIAL_PSW}"
                    sh "docker push ${IMAGE_NAME}:${IMAGE_VERSION}"
                    sh "docker push ${IMAGE_NAME}:latest"
                }
            }
        }
    }
}