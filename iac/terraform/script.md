<!-- Q5 -->
<!-- Click the node name → Jenkins shows a secret token (32-char string). Copy it. -->

<!-- Build a custom agent image with Terraform + AWS CLI pre-installed: -->

cat > Dockerfile.agent <<'EOF'
FROM jenkins/inbound-agent:latest
USER root
RUN apt-get update && apt-get install -y curl unzip \
    && curl -fsSL -o tf.zip https://releases.hashicorp.com/terraform/1.9.0/terraform_1.9.0_linux_amd64.zip \
    && unzip tf.zip -d /usr/local/bin/ && rm tf.zip \
    && curl -fsSL -o awscli.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip \
    && unzip awscli.zip && ./aws/install && rm -rf aws awscli.zip
USER jenkins
EOF

docker build -t jenkins-iac-agent -f Dockerfile.agent .


<!-- Then run the agent — replace <SECRET> with the token you copied: -->

docker run -d --name jenkins-agent \
  --restart unless-stopped \
  --network host \
  -e JENKINS_URL=http://localhost:8080 \
  -e JENKINS_AGENT_NAME=linux-agent \
  -e JENKINS_SECRET=<SECRET> \
  -e JENKINS_AGENT_WORKDIR=/home/jenkins/agent \
  jenkins-iac-agent