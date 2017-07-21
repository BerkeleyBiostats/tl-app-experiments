#!/bin/bash

#PBS -V
#PBS -l nodes=1
#PBS -l walltime=01:00:00
#PBS -N myRtest

module purge
module load R

cd $PBS_O_WORKDIR/

Rscript Rtest.r