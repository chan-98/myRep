#!/bin/bash

echo "This is a workflow for trimming and quality check of the sample SRR3924649 Paired End dataset"
#FastQC on raw data
mkdir fastqc-rawout
singularity exec --bind /opt fastqc.img fastqc mycoplasma_pneumoniae_F_100K.fastq mycoplasma_pneumoniae_R_100K.fastq -o fastqc-rawout --extract
mkdir trim-out
singularity exec --bind /opt trimmomatic.img trimmomatic PE -threads 4 -phred64 -trimlog trimlogfile.txt mycoplasma_pneumoniae_F_100K.fastq mycoplasma_pneumoniae_R_100K.fastq trim-out/mycoplasma_pneumoniae_F_100K_paired.fastq trim-out/mycoplasma_pneumoniae_F_100K_unpaired.fastq trim-out/mycoplasma_pneumoniae_R_100K_paired.fastq trim-out/mycoplasma_pneumoniae_R_100K_unpaired.fastq ILLUMINACLIP:all_adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 CROP:240 HEADCROP:19 MINLEN:50
mkdir fastqc-trimmedout
singularity exec --bind /opt fastqc.img fastqc trim-out/mycoplasma_pneumoniae_F_100K_paired.fastq trim-out/mycoplasma_pneumoniae_R_100K_paired.fastq trim-out/mycoplasma_pneumoniae_F_100K_unpaired.fastq trim-out/mycoplasma_pneumoniae_R_100K_unpaired.fastq -o fastqc-trimmedout --extract
echo 
echo "COMPLETE"
