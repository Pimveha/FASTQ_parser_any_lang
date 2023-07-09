#!/bin/bash

# extremely slow fastq parser :D
# example usage:
#  ./fastq_parser.sh -f input.fastq -h -s
#  ./fastq_parser.sh -f input.fastq -q

# -f optional input file
# -h only shows headers
# -s only shows sequences
# -hs shows both headers and sequences
# -q shows the average quality score (very slow)


input_file="../example.fastq"
# input_file="../fake.fastq"

while getopts "f:hsq" opt; do
    case $opt in
        f)
            input_file="$OPTARG"
            ;;
        h)
            output_header=true
            ;;
        s)
            output_sequence=true
            ;;
        q)
            output_average_qual=true
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done


if [ ! -f "$input_file" ]; then
    echo "Input file not found: $input_file" >&2
    exit 1
fi


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


        elif [ "$output_average_qual" = true ]
        then
            qual=""
            for ((i=0;i< ${#quality};i++)); do
                qchar=${quality:i:1}
                qual+=$(printf '+%d-33' "'$qchar")
                # echo $(printf '%d-33 + ' "'$qchar")
                # echo $qchar
            done

            echo ">$header"
            echo "$sequence"
            echo "(${qual:1})/${#quality}" | bc -l
            # echo "${#quality}" | bc


        else
            echo "Header: $header"
            echo "Sequence: $sequence"
            echo "Quality: $quality"
            echo ""
        fi
    fi
done < "$input_file"
