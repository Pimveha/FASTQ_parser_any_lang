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
        print NR-1, itter
        itter = 0;
    }
    # print "line number", NR

    # print itter
    if (itter == 0) {
        print "seq name: " $0;
    } else if (itter == 1) {
        print "sequence: " $0;
    } else if (itter == 3) {
        print "qual: " $0;
    }


    itter++;
    # print ord[substr($1,1,1)];
}

END {

}
