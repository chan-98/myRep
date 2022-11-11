#! /bin/bash

##samples=("$@")

## {samples[i]} is an array

#echo ${samples[@]}    #This works
#echo $@               #This works
#echo

#for ((i=0; i<${#samples[@]}; i++)); do
#	echo ${samples[i]}			#Also works
#done
#echo

#for i in ${samples[@]}
#do
#	echo $i					#Works. Use this
#	samplename=$(echo "$i" | cut -f 1 -d '.')
#	echo $samplename
#done
#echo
#echo

##mkdir outdir
##for i in ${samples[@]}
##do
##	echo $i
##	singularity exec --bind /opt fastqc.img fastqc $i -o outdir --extract
##done						# Works. Use this
#echo

#mkdir trim-out
#for i in ${samples[@]}
#do
#	echo $i
#	samplename=$(echo "$i" | cut -f 1 -d'.')
#	singularity exec --bind /opt trimmomatic.img trimmomatic PE -threads 4 -phred64 -trimlog trimlogfile.log $i trim-out/"$samplename"_paired.fastq trim-out/"$samplename"_unpaired.fastq ILLUMINACLIP:all_adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 CROP:240 HEADCROP:19 MINLEN:50
#done


samples=("$@")
echo The samples are
echo $@
echo

mkdir fastqc-rawout trim-out fastqc-trimout

for i in ${samples[@]}
do
	echo $i
	singularity exec --bind /opt fastqc.img fastqc "$i"_F.fastq "$i"_R.fastq -o fastqc-rawout --extract
	echo
	singularity exec --bind /opt trimmomatic.img trimmomatic PE -threads 4 -trimlog trimlogfile_"$i".log "$i"_F.fastq "$i"_R.fastq trim-out/"$i"_F_paired.fastq trim-out/"$i"_F_unpaired.fastq trim-out/"$i"_R_paired.fastq trim-out/"$i"_R_unpaired.fastq ILLUMINACLIP:all_adapters.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 CROP:240 HEADCROP:19 MINLEN:50 
	echo
	singularity exec --bind /opt fastqc.img fastqc trim-out/"$i"_F_paired.fastq trim-out/"$i"_F_unpaired.fastq trim-out/"$i"_R_paired.fastq trim-out/"$i"_R_unpaired.fastq -o fastqc-trimout --extract
	echo
done

