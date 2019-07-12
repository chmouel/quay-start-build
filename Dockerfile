FROM registry.access.redhat.com/ubi8/ubi:latest

RUN yum -y update && yum clean all

ADD run.sh /usr/local/bin/run

ENTRYPOINT ["/usr/local/bin/run"]
