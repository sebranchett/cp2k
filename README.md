# Running CP2K on DelftBlue

Following installation instructions here: https://github.com/cp2k/cp2k/blob/master/INSTALL.md.

## 1) In a Docker/Apptainer container
See https://www.cp2k.org/howto:build_and_run_cp2k_containers.
Following the Apptainer (Singularity) instructions for the production container described here: https://github.com/cp2k/cp2k-containers#readme.

This link documents the use of Apptainer on DelftBlue: https://doc.dhpc.tudelft.nl/delftblue/howtos/singularity.

Create these directories if you don't already have them:
```
mkdir /scratch/$USER/tmpdir
mkdir /scratch/$USER/.apptainer/cache
```

Create a new directory and copy `apptainer_version.sh` and `Si_bulk8.inp` into it. Move into the new directory. You can use git to do this, as follows:
```
cd /scratch/$USER
git clone https://github.com/sebranchett/cp2k.git
cd cp2k
```
The `Si_bulk8.inp` file is from [this tutorial](https://www.cp2k.org/howto:static_calculation) and is used under a [CC Attribution-ShareAlike 4.0 International license](http://creativecommons.org/licenses/by-sa/4.0/).

Get a CP2K container from DockerHub (this requires internet access and takes about 10 minutes):
```
apptainer pull docker://cp2k/cp2k:latest
```
There will be a new file `cp2k_latest.sif` in your directory.

Submit a test job:
```
sbatch apptainer_version.sh
```
This first performs a quick test to check whether CP2K runs. The output file `run_test.out` should contain information, but no errors.

The test job then runs a tutorial example described here: https://www.cp2k.org/howto:static_calculation.
The output file `Si_bulk8.out` should be as described in the tutorial, with a 'Total energy' of around -31.297885.

The [CP2K regression test](https://www.cp2k.org/dev:regtesting/) has been commented out, since it takes a long time.

## 2) Installation via Toolchain script
#TODO
See https://github.com/cp2k/cp2k/tree/master/tools/toolchain.
Maybe useful: https://www.cp2k.org/_media/events:2016_summer_school:building_cp2k.pdf.

## 3) Installation via Spack
#TODO
See https://manual.cp2k.org/trunk/getting-started/spack.html.
