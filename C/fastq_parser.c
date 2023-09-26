#include <stdio.h>
#include <string.h>

// void static_str_slicer()

typedef struct
{
    char header[1024];
    char sequence[1024];
    char quality[1024];
} FastQRecord;

int main(int argc, char *argv[])
{
    if (argc != 2)
    {
        fprintf(stderr, "Usage: %s <fastq_file>\n", argv[0]);
        return 1;
    }

    FILE *fptr;

    char buffer[1024];
    char base_line[256];
    char header_line[512];
    // char idkman_line[4];
    char quality_line[512];
    int line_count = 0;

    // fptr = fopen("../example.fastq", "r");
    fptr = fopen(argv[1], "r");

    if (fptr != NULL)
    {
        while (fgets(fasta_line, 512, fptr))
            line_count++ if (line_count % 4 == 0){
                header}
            {
                printf("%s", fasta_line);
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
