#!/usr/bin/awk -f

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

        total_qual = 0
        for (j=0; ++j <= length(seqs[i, "quality"]);){
            char = substr(seqs[i, "quality"], j, 1)
            total_qual += ord[char]
        }
        average_qual = total_qual/length(seqs[i, "quality"])
        seqs[i, "average_qual"] = average_qual


        # print seqs[i, "average_qual"]
    }
    # print seqs[1, "average_qual"]
}
