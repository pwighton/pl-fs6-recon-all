# FreeSurfer 6.0 Dockerfile for ChRIS

# Dockerfile for base container downloads fs 6.0 binaries
#  - https://github.com/corticometrics/fs6-cloud/blob/master/docker/dockerfile--fs6-payload
FROM corticometrics/fs6-payload

MAINTAINER fnndsc "dev@babymri.org"

# Configure Freesurfer 6.0 environment
# ---------------------------------------------------------------------------
ENV FS_OVERRIDE 0
ENV OS Linux
ENV FIX_VERTEX_AREA=
ENV FSF_OUTPUT_FORMAT nii.gz
ENV SUBJECTS_DIR /subjects
VOLUME /subjects
ENV MNI_DIR $FREESURFER_HOME/mni
ENV LOCAL_DIR $FREESURFER_HOME/local
ENV FSFAST_HOME $FREESURFER_HOME/fsfast
ENV MINC_BIN_DIR $FREESURFER_HOME/mni/bin
ENV MINC_LIB_DIR $FREESURFER_HOME/mni/lib
ENV MNI_DATAPATH $FREESURFER_HOME/mni/data
ENV FMRI_ANALYSIS_DIR $FREESURFER_HOME/fsfast
ENV PERL5LIB $FREESURFER_HOME/mni/lib/perl5/5.8.5
ENV MNI_PERL5LIB $FREESURFER_HOME/mni/lib/perl5/5.8.5
ENV PATH $FREESURFER_HOME/bin:$FREESURFER_HOME/fsfast/bin:$FREESURFER_HOME/tktools:$FREESURFER_HOME/mni/bin:$PATH

# Configure ChRIS environment
# ---------------------------------------------------------------------------
RUN yum -y update && yum -y install epel-release python35
RUN curl -s https://bootstrap.pypa.io/get-pip.py | python35

# Replecating behavior here:
#  https://github.com/FNNDSC/ubuntu-python3/blob/master/Dockerfile
RUN cd /usr/local/bin && ln -s /usr/bin/python3 python 

ENV APPROOT="/usr/src/fs6_recon_all"  VERSION="0.1"
ENV PATH $APPROOT:$PATH

WORKDIR $APPROOT
COPY ["fs6_recon_all", "${APPROOT}"]
COPY ["requirements.txt", "${APPROOT}"]
RUN pip3 install -r requirements.txt

CMD ["fs6_recon_all.py", "--json"]
