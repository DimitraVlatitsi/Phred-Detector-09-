#!/bin/bash
mkdir -p phred33 phred64

for fastq in *.fastq; do
    echo "Processing file: $fastq"
    
    Scores=$(awk 'NR % 4 == 0' "$fastq")
    
    NumericalASCII=$(echo "$Scores" | tr -d '\n' | od -An -t u1)

    NumericalASCII_list=$(echo "$NumericalASCII" | tr -s ' ' '\n' | grep -v '^32$')
    
    sorted=$(echo "$NumericalASCII_list" | grep -E '^[0-9]+$' | sort -n)

    Min=$(echo "$sorted" | head -n 1)
    Max=$(echo "$sorted" | tail -n 1)
    echo "Min: $Min"
    echo "Max: $Max"

    if [[ $Min -ge 64 && $Max -le 104 ]]; then
        echo "Phred+64 encoding detected for $fastq"
        mv "$fastq" phred64/
        echo "Moved $fastq to phred64/"
    elif [[ $Min -ge 33 && $Max -le 74 ]]; then
        echo "Phred+33 encoding detected for $fastq"
        mv "$fastq" phred33/
        echo "Moved $fastq to phred33/"
    else
        echo "Unrecognized encoding for $fastq"
        echo "Min: $Min, Max: $Max"
    fi

done
