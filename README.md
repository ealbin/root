
1) Edit line 4 in ./build.sh: 

    VERSION="vX-XX-XX" (see https://root.cern.ch/releases)

1a) Optional, edit line 8 in ./build.sh:

    PYTHON="/path/to/python/version" (PyROOT will be built using this python)

2) Run it:

    $ ./build.sh

3) Profit.


(check https://root.cern.ch/build-prerequisites for prerequisites)
