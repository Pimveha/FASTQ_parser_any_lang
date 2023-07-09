#!/usr/bin/awk -f

#simple sorting function, used for the N50 calculation
function insertion_sort(length_arr, seq_count) {
    for (i = 2; i <= seq_count; i++) {
        key = length_arr[i];
        j = i - 1;

        while (j > 0 && length_arr[j] > key) {
            length_arr[j + 1] = length_arr[j];
            j = j - 1;
        }

        length_arr[j + 1] = key;
    }
    # print length_arr
}



BEGIN {
    ARGV[1] = "../example.fastq";
    ARGC = 2;
    for(n=0; n<256; n++) ord[sprintf("%c",n)] = n;
    seq_count = 0;
    itter = 0;
}

{
    if ((NR-1) % 4 == 0) {
        seq_count++;
        itter = 0;
    }

    if (itter == 0) {
        seqs[seq_count, "name"] = $0;
    } else if (itter == 1) {
        seqs[seq_count, "sequence"] = $0;
    } else if (itter == 3) {
        seqs[seq_count, "quality"] = $0;
    }

    itter++;
    # print ord[substr($1,1,1)];
}

END {
    print "Sequence count: " seq_count;
    # print seq
    print seqs[1, "name"]

    for (i = 1; i <= seq_count; i++) {
        # print "Sequence", i, "name:", seqs[i, "name"];
        # print "Sequence", i, "sequence:", seqs[i, "sequence"];
        # print "Sequence", i, "quality:", seqs[i, "quality"];

        length_arr[i] = length(seqs[i, "sequence"])

        GC_amount = 0;
        total_qual = 0;
        for (j=0; ++j <= length(seqs[i, "quality"]);){
            char = substr(seqs[i, "quality"], j, 1);
            total_qual += ord[char];

            if (substr(seqs[i, "sequence"], j, 1) == "G") {
                GC_amount ++
            }
            else if (substr(seqs[i, "sequence"], j, 1) == "C") {
                GC_amount ++
            }
        }
        average_qual = total_qual/length(seqs[i, "quality"]);
        seqs[i, "average_qual"] = average_qual;

        # GC_amount = gsub(/[gGcC]/, "", seqs[i, "sequence"])
        GC_perc = GC_amount/length(seqs[i, "sequence"])*100;
        seqs[i, "GC_perc"] = GC_perc;


        # print seqs[i, "average_qual"]
    }
    print seqs[1, "average_qual"];
    print seqs[1, "sequence"];
    print seqs[1, "GC_perc"];


    # N50 calculation (L50)
    insertion_sort(length_arr, seq_count);
    cum_seq_length = 0
    for (i = 1; i <= seq_count; i++) {
        cum_seq_length += length_arr[i]
    }
    half_cum_seq_length = cum_seq_length/2
    
    for (i = seq_count; i > 0; i--) {
        temp_cum += length_arr[i]
        if (temp_cum > half_cum_seq_length) {
            N50 = length_arr[i]
            L50 = seq_count - i
            break;
        } 
    }
    print "N50:", N50
    print "L50:", L50
}
