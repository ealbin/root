
!!! Important note: if you're using Anaconda/Miniconda, the gcc etc compilers will 
likely die trying to compile root.  

!!! Please start your shell without sourcing Anaconda into your environment.

Also, because Anaconda isn't sourced, do NOT supply Anaconda python as your
python path (1a below) or the compilation will likely also bomb.
(You can, however, then use PyROOT with Anaconda all you want, after the compilation)

1) Edit line 4 in ./build.sh: 

    VERSION="vX-XX-XX" (see https://root.cern.ch/releases)

1a) Optional, edit line 12 in ./build.sh:

    PYTHON="/path/to/python/version" (PyROOT will be built using this python)

2) Run it:

    $ ./build.sh

3) Profit.


(check https://root.cern.ch/build-prerequisites for prerequisites)
