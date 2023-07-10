#!/usr/bin/env julia


function fastq_record(file_name::String)
    fastq_records = []
    record = Dict{String, String}() # assarr
    open(file_name) do file
        line_num = 0
        for line in eachline(file)
            line_num += 1
            if line_num % 4 == 1
                record["name"] = line[2:end] # ignoring @
            elseif line_num % 4 == 2
                record["sequence"] = line
            elseif line_num % 4 == 0
                record["quality"] = line
                push!(fastq_records, record)
                record = Dict{String, String}() # clean record
            end
        end
    end
    return fastq_records
end
    

function main()
    file_name = "../example.fastq"
    records = fastq_record(file_name)

    for record in records
        println("Name: ", record["name"])
        println("Sequence: ", record["sequence"])
        println("Quality: ", record["quality"])
        println("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
    end
end


main()