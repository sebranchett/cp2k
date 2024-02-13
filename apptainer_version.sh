#!/bin/bash

#SBATCH --job-name=CP2K-apptainer
#SBATCH --partition=compute
#SBATCH --account=innovation
#SBATCH --time=00:10:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=1
#SBATCH --mem=1GB

# find your account with:
# sacctmgr list -sp user $USER

export APPTAINER_TMPDIR=/scratch/$USER/tmpdir
export APPTAINER_CACHEDIR=/scratch/$USER/.apptainer/cache

# Following this link:
# https://github.com/cp2k/cp2k-containers

# First download a CP2K Docker container from the login node with:
# apptainer pull docker://cp2k/cp2k:latest

# Check the container runs. This test should not give any error messages
srun apptainer run cp2k_latest.sif cp2k -h -v > run_test.out

# Following this tutorial: https://www.cp2k.org/howto:static_calculation
srun apptainer run -B $PWD:/mnt cp2k_latest.sif cp2k.popt --maxtasks $SLURM_NTASKS_PER_NODE -o Si_bulk8.out Si_bulk8.inp

# Full regression test with:
# #SBATCH --nodes=1; #SBATCH --ntasks-per-node=24; #SBATCH --cpus-per-task=1; #SBATCH --mem=16GB
# takes a long time, at least more than 18 hours
# srun apptainer run -B $PWD:/mnt cp2k_latest.sif run_tests --maxtasks $SLURM_NTASKS_PER_NODE > regression_test.out
