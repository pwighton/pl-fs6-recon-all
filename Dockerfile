# Docker file for the fs6_recon_all plugin app
# Dockerfile for base container
#  - https://github.com/corticometrics/fs6-cloud/blob/master/docker/dockerfile--fs6-base
FROM corticometrics/fs6-base

MAINTAINER fnndsc "dev@babymri.org"

ENV APPROOT="/usr/src/fs6_recon_all"  VERSION="0.1"
COPY ["fs6_recon_all", "${APPROOT}"]
COPY ["requirements.txt", "${APPROOT}"]

WORKDIR $APPROOT

RUN yum -y update && yum -y install epel-release python35
RUN curl -s https://bootstrap.pypa.io/get-pip.py | python35
RUN pip3 install -r requirements.txt

ADD entrypoint-chris.bash /usr/local/bin/entrypoint-chris.bash
ENTRYPOINT ["/usr/local/bin/entrypoint-chris.bash"]

CMD ["fs6_recon_all.py", "--json"]
