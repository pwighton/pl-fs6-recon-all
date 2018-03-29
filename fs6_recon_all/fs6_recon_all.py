#!/usr/bin/python3

#                                                            _
# fs6_recon_all ds app
#
# (c) 2016 Fetal-Neonatal Neuroimaging & Developmental Science Center
#                   Boston Children's Hospital
#
#              http://childrenshospital.org/FNNDSC/
#                        dev@babyMRI.org
#
import os
import base64

# import the Chris app superclass
from chrisapp.base import ChrisApp
from subprocess import call

class Fs6_recon_all(ChrisApp):
    """
    See https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all.
    """
    AUTHORS         = 'Paul Wighton (paul@corticometrics.com)'
    SELFPATH        = os.path.dirname(os.path.abspath(__file__))
    SELFEXEC        = os.path.basename(__file__)
    EXECSHELL       = 'python3'
    TITLE           = 'FreeSurfer 6.0 recon-all stream'
    CATEGORY        = 'neuro; mri'
    TYPE            = 'ds'
    DESCRIPTION     = 'Neuromorphometric analysis of T1w MRI volumes'
    DOCUMENTATION   = 'https://surfer.nmr.mgh.harvard.edu/fswiki/recon-all'
    VERSION         = '0.1'
    LICENSE         = 'Opensource (MIT)'
    MAX_NUMBER_OF_WORKERS = 1  # Override with integer value
    MIN_NUMBER_OF_WORKERS = 1  # Override with integer value
    MAX_CPU_LIMIT         = '' # Override with millicore value as string, e.g. '2000m'
    MIN_CPU_LIMIT         = '' # Override with millicore value as string, e.g. '2000m'
    MAX_MEMORY_LIMIT      = '' # Override with string, e.g. '1Gi', '2000Mi'
    MIN_MEMORY_LIMIT      = '' # Override with string, e.g. '1Gi', '2000Mi'
    MIN_GPU_LIMIT         = 0  # Override with the minimum number of GPUs, as an integer, for your plugin
    MAX_GPU_LIMIT         = 0  # Override with the maximum number of GPUs, as an integer, for your plugin

    # Fill out this with key-value output descriptive info (such as an output file path
    # relative to the output dir) that you want to save to the output meta file when
    # called with the --saveoutputmeta flag
    OUTPUT_META_DICT = {}
 
    def define_parameters(self):
        """
        Define the CLI arguments accepted by this plugin app.
        """
        self.add_argument('--fs-key', dest='fs_key', type=str, optional=True,
                          default='cnVkb2xwaC5ubXJAZ21haWwuY29tCjM1Mzc3CiAqQ0liU0R6Z01RQlFRCiBGU0JBUC84aHBWOU0yCg==',
                          help='base64 encoding of freesurfer license file')
        self.add_argument('--subject', dest='subject', type=str, optional=False,
                          help='subject name to recon')
        self.add_argument('--ar1', dest='ar1', type=bool, optional=True,
                          default=False, help='Only run autorecon1')

    def run(self, options):
        """
        Define the code to be run by this plugin app.
        """
        # Write the license file
        # todo: replace "/freesurfer/license.txt" with ${FREESURFER_HOME}/license.txt
        #   where ${FREESURFER_HOME} is an env	 var
        with open("/freesurfer/license.txt", "wb") as text_file:
            text_file.write(base64.b64decode(options.fs_key))

        # Run recon-all
        if options.ar1:
            call(["recon-all", "-autorecon1", "-s", options.subject])
        else:
            call(["recon-all", "-all", "-s", options.subject])            

        # Copy recon'd subjets dir to outdir (could use some work)
        call(["cp", "-R", "/subjects/", "/outgoing/"])

if __name__ == "__main__":
    app = Fs6_recon_all()
    app.launch()
