#!/bin/bash
#SBATCH --job-name=aphan1
#SBATCH --partition=shared
#SBATCH --time=03-00:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=120000

#SBATCH --core-spec=0 ## Uncommented to allow jobs to request all cores on a node
##SBATCH --constraint="ib_qdr"

#SBATCH --error=aphantophryne1-%A.err ## %A - filled with jobid
#SBATCH --output=aphantophryne1-%A.out ## %A - filled with jobid
#SBATCH --mail-user=mbutler@hawaii.edu
#SBATCH --mail-type=BEGIN,END,FAIL,REQUEUE,TIME_LIMIT_80

source ~/.bash_profile

module load bio/Beast/2.7.5-GCC-11.3.0
##module load numlib/beagle-lib/3.0.2-intel-2018.5.274
beast -resume -beagle_CPU ../aphantophryne.xml
