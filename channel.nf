#!/usr/bin/env nextflow

def channel_samples(String samplesheet_path) {
        def channel_arr = []

        new File(samplesheet_path).withReader { reader ->
                def col_names = reader.readline()
                while ((line = reader.readLine()) != null) {
                        row = line.strip().split(',')
                        def sampleName = row[0]
                        if (row[1] == "false") {
                                def pairend = "false"
                                channel_arr << [sampleName, pairend, [file(row[2])]
                        } else if (row[1] == "true") {
                                def pairend = "true"
                                channel_arr << [sampleName, pairend, [file(row[2]), file(row[3])]
                        }
                }
        }
        return channels_arr
}
