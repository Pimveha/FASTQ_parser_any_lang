

def longest_buffers(filename = "example.fastq"):
    header, bases, idkman, qual = 0, 0, 0, 0
    with open(filename, "r") as f_in:
        for i, line in enumerate(f_in):
            if i % 4 == 0:
                # print(line)
                if len(line) > header:
                    header = len(line)
            elif i % 4 == 1:
                # print(line)
                if len(line) > bases:
                    bases = len(line)
            elif i % 4 == 2:
                # print(line)
                if len(line) > idkman:
                    idkman = len(line)
            elif i % 4 == 3:
                # print(line)
                if len(line) > qual:
                    qual = len(line)
    print(f"longest header line:\t{header}\nlongest base line:\t{bases}\nlongest idk line:\t{idkman}\nlongest quality line:\t{qual}")
        
                
longest_buffers()

# longest header line:    146
# longest base line:      439
# longest idk line:       2
# longest quality line:   439