#!/bin/bash
#PBS -l mem=22gb,nodes=1:ppn=16,walltime=24:00:00
#PBS -m abe
#PBS -M wyant008@umn.edu
#PBS -q lab

module load java

# Location of the Picard jar file
PICARD=/panfs/roc/itascasoft/picard/2.1.1/picard.jar

# SAM to be downsampled
INPUT_SAM=/panfs/roc/groups/9/morrellp/shared/Projects/Soy_Downsampling/sequence_handling/Read_Mapping/Archer.sam

# Output directory
OUT_DIR=/panfs/roc/groups/9/morrellp/shared/Projects/Soy_Downsampling/sequence_handling/Read_Mapping

mkdir -p ${OUT_DIR}
SAMPLE=$(basename "${INPUT_SAM}" .sam)

export _JAVA_OPTIONS="-Xmx22g"

java -jar "${PICARD}" DownsampleSam \
	INPUT="${INPUT_SAM}" \
	OUTPUT="${OUT_DIR}"/"${SAMPLE}"_15x.sam \
	STRATEGY=ConstantMemory \
	RANDOM_SEED=12 \
	PROBABILITY=0.5163

java -jar "${PICARD}" DownsampleSam \
        INPUT="${INPUT_SAM}" \
        OUTPUT="${OUT_DIR}"/"${SAMPLE}"_20x.sam \
        STRATEGY=ConstantMemory \
        RANDOM_SEED=12 \
        PROBABILITY=0.6884

java -jar "${PICARD}" DownsampleSam \
        INPUT="${INPUT_SAM}" \
        OUTPUT="${OUT_DIR}"/"${SAMPLE}"_25x.sam \
        STRATEGY=ConstantMemory \
        RANDOM_SEED=12 \
        PROBABILITY=0.8605

#java -jar "${PICARD}" DownsampleSam \
       # INPUT="${INPUT_SAM}" \
       # OUTPUT="${OUT_DIR}"/"${SAMPLE}"_30x.sam \
       # STRATEGY=ConstantMemory \
       # RANDOM_SEED=12 \
       # PROBABILITY=
