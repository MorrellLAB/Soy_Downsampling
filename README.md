# Soy_Downsampling
Processing scripts and documentation for the soybean downsampling sub-project

### Project Description
This project had two major goals:
1. Perform variant calling on the eight whole-genome accessions from [Kono et al. 2016]() against a newer version of the soybean reference for use as a resource in future projects.
2. Determine the tradeoff between sequencing depth and the power to detect variants in soybean. 

To accomplish these goals, three of the accessions at ~30x were downsampled in increments of 5x all the way down to 10x and variant discovery was performed on each depth level. The final calls were compared to genotyping from the SoySNP50k chip to determine accuracy and detection power.

### Raw Samples
Raw FASTQ files were downloaded from the SRA using the script `SRA_download.sh`, which relies on Tom Kono's [`SRA_Fetch.sh`](https://github.com/TomJKono/Misc_Utils/blob/efcdcec1198d51dc05078e149a751d28cb17da44/SRA_Fetch.sh). The list of SRR run numbers that were downloaded is found in the file `soy_run_numbers.txt`. The `.sra` files were validated and split into forward and reverse FASTQ files using `FASTQ_dumper.sh`.

Links to the SRA accessions for the samples:
* [IA3023](https://www.ncbi.nlm.nih.gov/sra/?term=SRR1297382)
* [M92_220](https://www.ncbi.nlm.nih.gov/sra/?term=SRR1164607)
* [Noir](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1250058)
* [Minsoy](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1541707)
* [Archer](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1250057)
* [Williams](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1541708) 
* [Williams 82 ISU](https://www.ncbi.nlm.nih.gov/sra/?term=SRR1298717)
* [Glycine Soya single](https://www.ncbi.nlm.nih.gov/sra/?term=SRR020181)
* [Glycine Soya 35bp paired](https://www.ncbi.nlm.nih.gov/sra/?term=SRR020182)
* [Glycine Soya 76bp paired](https://www.ncbi.nlm.nih.gov/sra/?term=SRR020190)

After splitting, the FASTQ files for M92_220 were concatenated with `zcat`. This was not necessary for the other samples.

```shell
zcat SRR1164607_1.fastq.gz\
  SRR1164608_1.fastq.gz\
  SRR1164609_1.fastq.gz\
  SRR1164610_1.fastq.gz\
  SRR1164611_1.fastq.gz\
  SRR1164612_1.fastq.gz\
  SRR1164613_1.fastq.gz\
  SRR1164614_1.fastq.gz > M92_220_1.fastq
```

### sequence_handling

The FASTQ files were trimmed of adapters, read mapped, and converted to BAM format using commit [e82460c](https://github.com/MorrellLAB/sequence_handling/commit/e82460c2d948dd44ea542f925d2056dc2e94903b) of [sequence_handling](https://github.com/MorrellLAB/sequence_handling). The config file used to run sequence_handling is found in [Config](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/Config). The following handlers were executed in the listed order:

1. Quality_Assessment: Quality summary output for each FASTQ is located in [SOYDOWN_quality_summary.txt](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/SOYDOWN_quality_summary.txt)
2. Adapter_Trimming
3. Read_Mapping: Different read mapping parameters were used to compensate for different read lengths, and are summarized in [Read_Mapping_Parameters.txt](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/Read_Mapping_Parameters.txt). The two different Williams samples and the three different Glycine soya samples were merged after read mapping using `samtools merge`.
4. SAM_Processing: Mapping summary output for each BAM is located in [SOYDOWN_mapping_summary.txt](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/SOYDOWN_mapping_summary.txt)
5. Coverage_Mapping: Coverage summary output for each BAM is located in [SOYDOWN_coverage_summary.txt](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/SOYDOWN_coverage_summary.txt). The mean coverage statistic was used as the basis for downsampling each sample. [Downsample.sh](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/Downsample.sh) was run on each raw SAM file using the percentages found in [Downsampling_Percentages.xlxs](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/Downsampling_Percentages.xlsx). The downsampled SAM files were processed to BAM files using SAM_Processing and the downsampled coverage was double-checked using Coverage_Mapping. 
6. Haplotype_Caller
7. Genotype_GVCFs: After Genotype_GVCFs, the VCF parts for each sample were merged into a single file using [VCFtools](https://vcftools.github.io/man_latest.html) `vcf-concat`
9. Variant_Filtering: Different filtering parameters were used for each depth level and are summarized in [Variant_Filtering_Parameters.txt](https://github.com/MorrellLAB/Soy_Downsampling/blob/master/sequence_handling/Variant_Filtering_Parameters.txt)
10. Variant_Analysis: Heterozygosity, missingness, Ts/Tv, MAF histogram, and SNP count outputs for each depth level are located [here](https://github.com/MorrellLAB/Soy_Downsampling/tree/master/sequence_handling/Variant_Analysis)

The final VCF file for all eight samples at their full depth can be downloaded [here](). (Not available yet)

### Results

To be updated later.

### To-Do

* Put final VCF file on DRUM
