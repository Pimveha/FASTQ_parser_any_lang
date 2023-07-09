#!/bin/bash

input_file="../example.fastq"

while getopts "hs" opt; do
    case $opt in
        h)
            output_header=true
            ;;
        s)
            output_sequence=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

while IFS= read -r line
do
    if [[ $line =~ ^@ ]]
    then
        header="${line:1}"
        

        read -r sequence
        read -r separator
        read -r quality
        

        if [ "$output_header" = true ] && [ "$output_sequence" = true ]
        then
            echo ">$header"
            echo "$sequence"
        

        elif [ "$output_header" = true ]
        then
            echo "$header"


        elif [ "$output_sequence" = true ]
        then
            echo "$sequence"


        else
            echo "Header: $header"
            echo "Sequence: $sequence"
            echo "Quality: $quality"
        fi
    fi
done < "$input_file"
