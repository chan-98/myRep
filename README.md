# myRep
Contains records of bash scripts and NF scripts written as part of training.

## practice

### Date: 09 Nov 2022

`trim_and_qc.sh`

TRIMMING AND QUALITY CHECK OF NGS DATASET

Dataset used: SRR3924649
Whole genome sequence of Mycoplasma pneumoniae 100K - Paired End stranded

The program performs FastQC quality check on the raw dataset (forward and reverse)
Performs trimming of adapter sequences
And Fastqc of the trimmed dataset

Outputs are stored in separate directories.

### Date: 11 Nov 2022

`test_auto.sh`

TRIMMING AND QUALITY CHECK OF NGS DATASET

Improved script to take any sample ID of paired end data and perform:
1. FastQC of the raw data
2. Trimming of the raw data
3. FastQC of the trimmed data

Outputs are stored in separate directories

