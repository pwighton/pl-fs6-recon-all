################################
pl-fs6-recon-all
################################


Abstract
********

See https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all

Run
***

Using ``docker run``
====================

Assign an "input" directory to ``/incoming`` and an output directory to ``/outgoing``

.. code-block:: bash

    docker run --rm -v $(pwd)/in:/incoming -v $(pwd)/out:/outgoing   \
            fnndsc/pl-fs6-recon-all fs6_recon_all.py            \
            /incoming /outgoing

This will ...

Make sure that the host ``$(pwd)/out`` directory is world writable!







