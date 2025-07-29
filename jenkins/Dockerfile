FROM jenkins/jenkins:lts

USER root

# Install Docker CLI
RUN apt-get update && apt-get install -y docker.io

# Add Jenkins user to Docker group
RUN usermod -aG docker jenkins

# Install plugins using new CLI
RUN jenkins-plugin-cli --plugins \
    blueocean \
    docker-workflow \
    git \
    workflow-aggregator \
    trivy \
    pipeline-utility-steps \
    kubernetes-cli \
    credentials-binding \
    configuration-as-code \
    github \
    kubernetes-cd \
    aws-credentials \
    aws-java-sdk \
    htmlpublisher \
    junit \
    matrix-auth \
    ssh-agent

USER jenkins
