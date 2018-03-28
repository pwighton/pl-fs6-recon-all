# pl-fs6-recon-all

## Abstract

ChRIS plugin to run the [FreeSurfer 6.0](https://surfer.nmr.mgh.harvard.edu/) [`recon-all`](https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all) stream.

## Building the container

```
docker build -t pwighton/pl-fs6-recon-all .
```

## Running

Assign an "input" directory to ``/subjects`` and an output directory to ``/outgoing``

Also required is the environment variable `FS_KEY` that is a base64 encoding of the FreeSurfer license file.  You can apply for a license file [here](https://surfer.nmr.mgh.harvard.edu/registration.html).  Once you have the file, run the following command to generate the `FS_KEY` string

```
base64 -w999 ~/Downloads/license.txt
```

The current string for the ChRIS license file is: `cnVkb2xwaC5ubXJAZ21haWwuY29tCjM1Mzc3CiAqQ0liU0R6Z01RQlFRCiBGU0JBUC84aHBWOU0yCg==`

### Examples

This will run the entire stream (several hours):
```
docker run -it --rm \
  -e FS_KEY='cnVkb2xwaC5ubXJAZ21haWwuY29tCjM1Mzc3CiAqQ0liU0R6Z01RQlFRCiBGU0JBUC84aHBWOU0yCg==' \
  -v /tmp/sub/in/:/subjects \
  -v /tmp/sub/out:/outgoing \
  fnndsc/pl-fs6-recon-all \
    fs6_recon_all.py \
      --subject bert /incomming /outgoing
```

This will only do skull stripping.  See [here](https://surfer.nmr.mgh.harvard.edu/fswiki/ReconAllDevTable) for more info on the stream
```
docker run -it --rm \
  -e FS_KEY='cnVkb2xwaC5ubXJAZ21haWwuY29tCjM1Mzc3CiAqQ0liU0R6Z01RQlFRCiBGU0JBUC84aHBWOU0yCg==' \
  -v /tmp/sub/in/:/subjects \
  -v /tmp/sub/out:/outgoing \
  fnndsc/pl-fs6-recon-all \
    fs6_recon_all.py \
      --subject bert \
      --ar1 \
      /incomming /outgoing
```

To convert the `.mgz` outputs to nifit
This will only do skull stripping.  See [here](https://surfer.nmr.mgh.harvard.edu/fswiki/ReconAllDevTable) for more info on the stream

```
docker run -it --rm \
  -e FS_KEY='cnVkb2xwaC5ubXJAZ21haWwuY29tCjM1Mzc3CiAqQ0liU0R6Z01RQlFRCiBGU0JBUC84aHBWOU0yCg==' \
  -v /tmp/sub/out:/tmp/sub/out \
  corticometrics/fs6-base \
    mri_convert /tmp/sub/out/subjects/bert/mri/brainmask.mgz \
                /tmp/sub/out/subjects/bert/mri/brainmask.nii.gz
```

This will convert `brainmask.mgz` to `brainmask.nii.gz`
