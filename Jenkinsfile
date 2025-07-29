pipeline {
    agent any

    tools {
        nodejs 'nodejs-22-6-0'
        ruby 'Ruby_3.1'
    }

    environment {
        // MongoDB Connection
        MONGO_URI = 'mongodb+srv://supercluster.d83jj.mongodb.net/superData'
        MONGO_USERNAME = credentials('mongo-db-username')
        MONGO_PASSWORD = credentials('mongo-db-password')

        // Docker
        DOCKER_REGISTRY = 'docker.io'
        DOCKER_CREDENTIALS_ID = 'dockerhub-credentials'
        IMAGE_NAME = "amandeol063/budget-app"

        // Kubernetes
        KUBECONFIG_CREDENTIALS_ID = 'kubeconfig'
        KUBE_NAMESPACE = 'default'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Start Dependencies (Docker Compose)') {
            steps {
                sh 'docker-compose up -d --build'
            }
        }

        stage('Install NPM Dependencies') {
            steps {
                sh 'npm install --no-audit'
            }
        }

        stage('NPM Dependency Audit') {
            steps {
                sh 'npm audit --audit-level=critical || true'
            }
        }

        stage('Ruby Security Scan') {
            steps {
                sh 'gem install brakeman bundler-audit'
                sh 'brakeman -q -o brakeman-report.json'
                sh 'bundle audit check --update || true'
                archiveArtifacts artifacts: 'brakeman-report.json', allowEmptyArchive: true
            }
        }

        stage('Unit Testing') {
            steps {
                sh 'npm test'
            }
        }

        stage('Code Coverage') {
            steps {
                catchError(buildResult: 'SUCCESS', message: 'Non-blocking coverage issue', stageResult: 'UNSTABLE') {
                    sh 'npm run coverage'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${BUILD_NUMBER}")
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                script {
                    sh """
                    trivy image ${IMAGE_NAME}:${BUILD_NUMBER} \
                    --severity CRITICAL,HIGH \
                    --exit-code 1 \
                    --format json -o trivy-image-CRITICAL-results.json
                    """
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login ${DOCKER_REGISTRY} -u $DOCKER_USER --password-stdin"
                    sh "docker push ${IMAGE_NAME}:${BUILD_NUMBER}"
                }
            }
        }

        stage('Kubernetes Lint') {
            steps {
                sh 'kube-score score k8s/*.yaml || true'
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                withCredentials([file(credentialsId: KUBECONFIG_CREDENTIALS_ID, variable: 'KUBECONFIG')]) {
                    sh "kubectl --kubeconfig=$KUBECONFIG set image deployment/budget-app budget-app=${IMAGE_NAME}:${BUILD_NUMBER} -n ${KUBE_NAMESPACE}"
                    sh "kubectl --kubeconfig=$KUBECONFIG rollout status deployment/budget-app -n ${KUBE_NAMESPACE}"
                }
            }
        }

        stage('Integration Testing') {
            when {
                expression { return env.GIT_BRANCH ==~ /feature\/.*/ }
            }
            steps {
                sh 'bash dev-integration-test-vm.sh'
            }
        }

    }

    post {
        always {
            junit allowEmptyResults: true, testResults: 'test-results.xml'
            publishHTML([
                allowMissing: true,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: 'coverage/lcov-report',
                reportFiles: 'index.html',
                reportName: 'Code Coverage HTML Report'
            ])
            sh 'trivy convert --format template --template "/usr/local/share/trivy/templates/html.tpl" --output trivy-image-CRITICAL-results.html trivy-image-CRITICAL-results.json'
            publishHTML([
                allowMissing: true,
                alwaysLinkToLastBuild: true,
                keepAll: true,
                reportDir: "./",
                reportFiles: "trivy-image-CRITICAL-results.html",
                reportName: "Trivy Image Critical Vul Report"
            ])
            sh 'docker-compose down || true'
            cleanWs()
        }
    }
}
