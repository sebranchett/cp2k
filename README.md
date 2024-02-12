# Running CP2K on DelftBlue

Following installation instructions: https://github.com/cp2k/cp2k/blob/master/INSTALL.md.

## In a Docker/Apptainer container
See https://www.cp2k.org/howto:build_and_run_cp2k_containers.
Following the Apptainer (Singularity) instructions for the production container here: https://github.com/cp2k/cp2k-containers#readme.

This link documents the use of Apptainer on DelftBlue: https://doc.dhpc.tudelft.nl/delftblue/howtos/singularity.

Create these directories if you don't already have them:
```
mkdir /scratch/$USER/tmpdir
mkdir /scratch/$USER/.apptainer/cache
```

Create a new directory and copy `apptainer_version.sh` into it. You can do this using git:
```
cd /scratch/$USER
git clone https://github.com/sebranchett/cp2k.git
cd cp2k
```

Get a CP2K container from DockerHub (this requires internet access and takes about 10 minutes):
```
apptainer pull docker://cp2k/cp2k:latest
```
There will be a new file `cp2k_latest.sif` in your directory.

Submit a test job:
```
sbatch apptainer_version.sh
```
This first runs a quick (around 10 minutes) test to check whether CP2K runs. The output file `run_test.out` should contain information, but no errors.

The test job then runs the [CP2K regression test suite](https://www.cp2k.org/dev:regtesting/).

## Installation via Toolchain script
#TODO
See https://github.com/cp2k/cp2k/tree/master/tools/toolchain.

## Installation via Spack
#TODO
See https://manual.cp2k.org/trunk/getting-started/spack.html.
