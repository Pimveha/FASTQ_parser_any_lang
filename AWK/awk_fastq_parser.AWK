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
        # print NR-1, itter
        itter = 0;
    }
    # print "line number", NR

    # print itter
    if (itter == 0) {
        # print "seq name: " $0;
        # seqs[seq_count]["name"] = $0
        seqs[seq_count, "name"] = $0;
    } else if (itter == 1) {
        # print "sequence: " $0;
        # seqs[seq_count]["sequence"] = $0
        seqs[seq_count, "sequence"] = $0;
    } else if (itter == 3) {
        # print "qual: " $0;
        # seqs[seq_count]["quality"] = $0
        seqs[seq_count, "quality"] = $0;
    }


    itter++;
    # print ord[substr($1,1,1)];
}

END {
    print "Sequence count: " seq_count;
    # print seq
    print seqs[1, "name"]

    # for (i = 1; i <= seq_count; i++) {
    #     print "Sequence", i, "name:", seqs[i, "name"];
    #     print "Sequence", i, "sequence:", seqs[i, "sequence"];
    #     print "Sequence", i, "quality:", seqs[i, "quality"];
    # }
}
