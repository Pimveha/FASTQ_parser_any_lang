#!/usr/bin/env julia


function fastq_record(file_name::String, qual_conv::Bool=true)
    fastq_records = []
    # record = Dict{String, String}()
    record = Dict{String, Any}()
    # record = Dict{String, Union{String, Array{Int}}}() # assarr
    open(file_name) do file
        line_num = 0
        for line in eachline(file)
            line_num += 1
            if line_num % 4 == 1
                record["name"] = line[2:end] # ignoring @
            elseif line_num % 4 == 2
                record["sequence"] = line
            elseif line_num % 4 == 0
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
        end
        println(fastq_records)
    end
    return fastq_records
end
    

function main()
    file_name = "../example.fastq"
    records = fastq_record(file_name)
    println(records)

    # for record in records
    #     println("Name: ", record["name"])
    #     println("Sequence: ", record["sequence"])
    #     println("Quality: ", record["quality"])
    #     println("-=-=-=-=-=-=-=-=-=-=-=-=-=-=-")
    # end
end


main()