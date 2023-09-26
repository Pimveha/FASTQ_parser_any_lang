#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void static_slicer(char *sequence, int trim_len)
{
    int string_length = strlen(sequence);

    // if (startTrim >= string_length || endTrim >= string_length) {
    //     fprintf(stderr, "Trim values exceed sequence length\n");
    //     return;
    // }

    memmove(sequence, sequence + trim_len, string_length - (trim_len * 2) + 1);
}

typedef struct
{
    char header[256];
    char sequence[512];
    char quality[512];
} FastQRecord;

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s <fastq_file>\n", argv[0]);
        return 1;
    }

    FILE *fptr;

    char buffer[512];
    FastQRecord record;
    int line_count = 0;

    // fptr = fopen("../example.fastq", "r");
    fptr = fopen(argv[1], "r");

    if (fptr != NULL)
    {
        while (fgets(buffer, sizeof(buffer), fptr))
        {

            line_count++;

            if (line_count % 4 == 1)
            {
                snprintf(record.header, sizeof(record.header), "%s", buffer);
            }
            else if (line_count % 4 == 2)
            {
                snprintf(record.sequence, sizeof(record.sequence), "%s", buffer);
            }
            else if (line_count % 4 == 0)
            {
                snprintf(record.quality, sizeof(record.quality), "%s", buffer);

                printf("Header: %s", record.header);
                printf("Sequence: %s", record.sequence);
                printf("Quality: %s", record.quality);
            }

            // {
            //     printf("%s", fasta_line);
            // }
        }
    }
    else
    {
        printf("Not able to open the file.");
        fclose(fptr);
        return 0;
    }
    fclose(fptr);
    return 1;
}

// time for i in {1..10}; do ./a.out ../example.fastq; done
// real    0m2.754s
// user    0m0.153s
// sys     0m0.278s