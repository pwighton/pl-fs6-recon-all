################################
pl-fs6-recon-all
################################


Abstract
********

Runs the [FreeSurfer 6.0](https://surfer.nmr.mgh.harvard.edu/) [`recon-all`](https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all) stream.

Run
***

Building the container
====================

.. code-block:: bash

    docker build -t fnndsc/pl-fs6-recon-all .

Using ``docker run``
====================

Assign an "input" directory to ``/incoming`` and an output directory to ``/outgoing``

.. code-block:: bash

docker run -it --rm \
  -e FS_KEY='cGF1bEBjb3J0aWNvbWV0cmljcy5jb20KMzA0NDQKICpDZ3lrR3o2bnNYaGcKIEZTVXQweHY5UmlGcWMK' \
  -v /tmp/sub/in/:/subjects \
  -v /tmp/sub/out:/outgoing \
  fnndsc/pl-fs6-recon-all \
    fs6_recon_all.py \
      --subject bert /incomming /outgoing

This will run the entire stream (several hours)

.. code-block:: bash

docker run -it --rm \
  -e FS_KEY='cGF1bEBjb3J0aWNvbWV0cmljcy5jb20KMzA0NDQKICpDZ3lrR3o2bnNYaGcKIEZTVXQweHY5UmlGcWMK' \
  -v /tmp/sub/in/:/subjects \
  -v /tmp/sub/out:/outgoing \
  fnndsc/pl-fs6-recon-all \
    fs6_recon_all.py \
      --subject bert \
      --ar1 \
      /incomming /outgoing

This will only do skull stripping.  See [here](https://surfer.nmr.mgh.harvard.edu/fswiki/ReconAllDevTable) for more info on the stream

Make sure that the host ``$(pwd)/out`` directory is world writable!







