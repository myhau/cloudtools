FROM ubuntu:bionic-20200112

ARG DOCKER_VERSION="5:19.03.5~3-0~ubuntu-bionic"
ARG AZURE_CLI_VERSION="2.0.80-1~bionic"
ARG KUBECTL_VERSION="v1.17.0"
ARG HELM_VERSION="v3.0.3"
ARG TERRAFORM_VERSION="0.12.24"

RUN apt-get update -y && apt-get install -y zip curl gpg ca-certificates

# docker
RUN echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list.d/docker.list
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# azure cli
RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli bionic main" > /etc/apt/sources.list.d/azure-cli.list
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /etc/apt/trusted.gpg.d/microsoft.asc.gpg

RUN apt-get update -y && apt-get install -y docker-ce-cli=${DOCKER_VERSION} azure-cli=${AZURE_CLI_VERSION}

# kubectl
RUN curl -sL "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" > /bin/kubectl && chmod +x /bin/kubectl

# helm
RUN curl -sL -O "https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz" && tar zxvf "helm-${HELM_VERSION}-linux-amd64.tar.gz" && mv linux-amd64/helm /bin/helm

# terraform
RUN curl -sL -O "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip" && mv terraform bin/terraform
