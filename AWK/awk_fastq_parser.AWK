#!/usr/bin/awk -f


BEGIN {
    ARGV[1] = "../example.fastq"
    ARGC = 2
}
{
print $1
}
END {

}