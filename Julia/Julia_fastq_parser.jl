#!/usr/bin/env julia
# the biggest bottleneck of this code is the generation of small dictionaries

function fastq_record(file_name::String, qual_conv::Bool=true)
    fastq_records = []
    # record = Dict{String, String}()
    record = Dict{String, Any}()
    # record = Dict{String, Union{String, Array{Int}}}() # assarr
    file = open(file_name, "r")
    for line in eachline(file)
        record["name"] = line[2:end] # ignoring @
        line = readline(file)
        readline(file)
        record["sequence"] = line
        line = readline(file)
        if qual_conv
            qual_list = []
            for char in line
                int_val = Int(Char(char))
                push!(qual_list, int_val)
            end
            # println(qual_list)
            record["quality"] = qual_list
            push!(fastq_records, record)
        else
            record["quality"] = line
            push!(fastq_records, record)
        record = Dict{String, Any}() # clean record
        end
    end
    return fastq_records
end


function main()
    file_name = "../example.fastq"
    records = fastq_record(file_name)

    infile = open("out.txt", "w")
    println(infile, records)
    close(infile)
    # for record in records
    #     println("Name: ", record["name"])
    #     println("Sequence: ", record["sequence"])
    #     println("Quality: ", record["quality"])
    #     println("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
    # end
end

# using BenchmarkTools
#@time main()
main()
