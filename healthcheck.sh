#! /bin/sh

command -v clustalw && command -v probcons \
&& command -v conda && command -v locarna \
&& command -v contrafold && command -v TurboFold \
&& command -v cargo && command -v consprob \
&& command -v consalifold && command -v consprob_trained \
&& command -v consalign && command -v RNAfold \
&& command -v mafft && command -v centroid_fold \
&& command -v PETfold && command -v contralign \
&& command -v raf && command -v linearturbofold \
&& command -v dafs || exit 1
