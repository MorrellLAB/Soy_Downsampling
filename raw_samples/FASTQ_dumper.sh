#!/bin/bash
#PBS -l mem=16g,nodes=1:ppn=16,walltime=24:00:00
#PBS -m abe
#PBS -M wyant008@umn.edu

set -euo pipefail

#    Peter L. Morrell, 26 July 2016, St. Paul, MN
#    Updated 27 October 2016
#    Dependencies: SRA Toolkit
#    Requires bash version 4+ for mapfile

module load sratoolkit
module load parallel

#    directory for out of fastq.gz files
WORKING=/panfs/roc/scratch/wyant008/Soy_Downsampling/Raw_Samples

LIST=/panfs/roc/scratch/wyant008/Soy_Downsampling/Raw_Samples/SRA.list

#   initalize the array that will hold a list of SRA files
declare -a SRA=($(cat "${LIST}"))
echo "${#SRA[@]} samples"
cd ${WORKING}
parallel --verbose "vdb-validate {}" ::: ${SRA[@]}
parallel --verbose "fastq-dump --split-files -I -F --gzip {} --outdir ${WORKING}" ::: ${SRA[@]}
