# Soy_Downsampling
Processing scripts and documentation for the Soy downsampling sub-project

### Project Description
The goal of this project is to determine the tradeoff between sequencing depth and SNP calling accuracy for Soybean. Lower coverage sequencing is much cheaper, however the ability to accurately detect variants decreases with decreasing coverage. Seven high coverage (28x - 106x) whole-genome soybean resequencing samples will be downsampled to various coverages (15x, 20x, 25x, 30x). The SNP calls from each downsampled coverage will be compared to the full coverage calls to determine the false positive and false negative rates. For three lines with genotyping data (Noir, Minsoy, Archer), the SNP calls will also be compared to the SoySNP50K chip.

### Raw Samples
Raw fastq files were downloaded from the SRA using the script `SRA_download.sh`, which relies on Tom Kono's [`SRA_Fetch.sh`](https://github.com/TomJKono/Misc_Utils/blob/efcdcec1198d51dc05078e149a751d28cb17da44/SRA_Fetch.sh). The list of SRR run numbers that were downloaded is found in the file `soy_run_numbers.txt`. The `.sra` files were validated and split into forward and reverse FASTQ files using `FASTQ_dumper.sh`.

Links to the SRA accessions for the samples:
* [IA3023](https://www.ncbi.nlm.nih.gov/sra/?term=SRR1297382)
* [M92_220](https://www.ncbi.nlm.nih.gov/sra/?term=SRR1164607)
* [Noir](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1250058)
* [Minsoy](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1541707)
* [Archer](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1250057)
* [Williams](https://www.ncbi.nlm.nih.gov/sra/?term=SRX1541708)
* [Glycine soja SE](https://www.ncbi.nlm.nih.gov/sra/SRX007146[accn])
* [Glycine soja PE](https://www.ncbi.nlm.nih.gov/sra/SRX007149[accn])

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
##### Raw FASTQ -> BAM
The FASTQ files were trimmed of adapters, read mapped, and converted to BAM format using commit [?????](https://github.com/MorrellLAB/sequence_handling) of [sequence_handling](https://github.com/MorrellLAB/sequence_handling). The config file needed to run all of the analysis is found in `Config`.
##### Coverage Calculation

##### Downsampling

##### SNP Calling

### Results
