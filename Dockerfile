FROM alpine:3.18

# Versions for ansible that we will install
ENV ANSIBLE_CORE_VERSION=2.17
ENV ANSIBLE_VERSION=10.3
ENV ANSIBLE_LINT=24.7

# Install needed alpine packages
RUN apk --no-cache add sudo python3 py3-pip openssl ca-certificates sshpass openssh-client rsync git && \
    apk --no-cache add --virtual build-dependencies python3-dev libffi-dev musl-dev gcc cargo build-base

# Install needed python packages
RUN pip3 install --upgrade pip wheel && \
    pip3 install --upgrade cryptography cffi && \
    pip3 install boto3 boto botocore netaddr mitogen jmespath&& \
    pip3 install --upgrade pywinrm

# Install ansible
RUN pip3 install ansible-core==${ANSIBLE_CORE_VERSION} && \
    pip3 install ansible==${ANSIBLE_VERSION} && \
    pip3 install --ignore-installed ansible-lint==${ANSIBLE_LINT}

# Cleanup
RUN apk del build-dependencies && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache/pip && \
    rm -rf /root/.cargo

# Configuration and setup
RUN mkdir /ansible && \
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

# Copy the code into the image
COPY . /ansible

# Set the starting environment
WORKDIR /ansible
CMD [ "ansible-playbook", "--version" ]