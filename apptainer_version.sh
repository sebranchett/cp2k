#!/bin/bash

#SBATCH --job-name=CP2K-apptainer
#SBATCH --partition=compute
#SBATCH --account=innovation
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB

# find your account with:
# sacctmgr list -sp user $USER

module load 2023r1
module load openmpi
export APPTAINER_TMPDIR=/scratch/$USER/tmpdir
export APPTAINER_CACHEDIR=/scratch/$USER/.apptainer/cache

# Following this link:
# https://github.com/cp2k/cp2k-containers

# First download a CP2K Docker container from the login node with:
# apptainer pull docker://cp2k/cp2k:latest
# and then make it executable:
# chmod a+x cp2k_latest.sif

# Check the container runs. This test should not give any error messages
srun apptainer run cp2k_latest.sif cp2k -h -v > run_test.out

# Full regression test
srun apptainer run -B $PWD:/mnt cp2k_latest.sif run_tests --maxtasks $SLURM_NTASKS_PER_NODE > regression_test.out

