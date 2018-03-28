# pl-fs6-recon-all

## Abstract

Runs the [FreeSurfer 6.0](https://surfer.nmr.mgh.harvard.edu/) [`recon-all`](https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all) stream.

## Building the container

```
docker build -t pwighton/pl-fs6-recon-all .
```

## Running

Assign an "input" directory to ``/subjects`` and an output directory to ``/outgoing``

Also required is the environment variable FS_KEY that defines the FreeSurfer license file.

```
docker run -it --rm \
  -e FS_KEY='cGF1bEBjb3J0aWNvbWV0cmljcy5jb20KMzA0NDQKICpDZ3lrR3o2bnNYaGcKIEZTVXQweHY5UmlGcWMK' \
  -v /tmp/sub/in/:/subjects \
  -v /tmp/sub/out:/outgoing \
  fnndsc/pl-fs6-recon-all \
    fs6_recon_all.py \
      --subject bert /incomming /outgoing
```

This will run the entire stream (several hours)

```
docker run -it --rm \
  -e FS_KEY='cGF1bEBjb3J0aWNvbWV0cmljcy5jb20KMzA0NDQKICpDZ3lrR3o2bnNYaGcKIEZTVXQweHY5UmlGcWMK' \
  -v /tmp/sub/in/:/subjects \
  -v /tmp/sub/out:/outgoing \
  fnndsc/pl-fs6-recon-all \
    fs6_recon_all.py \
      --subject bert \
      --ar1 \
      /incomming /outgoing
```

This will only do skull stripping.  See [here](https://surfer.nmr.mgh.harvard.edu/fswiki/ReconAllDevTable) for more info on the stream

.. code-block:: bash
docker run -it --rm \
  -e FS_KEY='cGF1bEBjb3J0aWNvbWV0cmljcy5jb20KMzA0NDQKICpDZ3lrR3o2bnNYaGcKIEZTVXQweHY5UmlGcWMK' \
  -v /tmp/sub/out:/tmp/sub/out \
  corticometrics/fs6-base \
    mri_convert /tmp/sub/out/subjects/bert/mri/brainmask.mgz \
                /tmp/sub/out/subjects/bert/mri/brainmask.nii.gz

This will convert `brainmask.mgz` to `brainmask.nii.gz`

Make sure that the host ``$(pwd)/out`` directory is world writable!







