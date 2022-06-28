ARG VERSION=latest
ARG OS=debian
FROM cloudposse/geodesic:$VERSION-$OS

# Add configuration options such as setting a custom BANNER,
# setting the initial AWS_PROFILE and AWS_DEFAULT_REGION, etc. here

ENV BANNER="spookyfox"
ENV AWS_PROFILE="default"
ENV AWS_DEFAULT_REGION="us-west-2"
RUN apt-get update
RUN apt-get install atmos -y -u
RUN apt-get install ansible -y -u
RUN ansible-galaxy collection install community.general
RUN mkdir .ssh
COPY ansible/configs/ssh_config .ssh/config
COPY ansible/ansible.cfg .ansible.cfg