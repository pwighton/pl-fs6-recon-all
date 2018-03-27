# Docker file for the fs6_recon_all plugin app

FROM fnndsc/ubuntu-python3:latest
MAINTAINER fnndsc "dev@babymri.org"

ENV APPROOT="/usr/src/fs6_recon_all"  VERSION="0.1"
COPY ["fs6_recon_all", "${APPROOT}"]
COPY ["requirements.txt", "${APPROOT}"]

WORKDIR $APPROOT

RUN pip install -r requirements.txt

CMD ["fs6_recon_all.py", "--json"]