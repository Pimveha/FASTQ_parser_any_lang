local open = io.open
-- local inspect = require('inspect')

function average_qual(quality)
    local qual_total = 0
    for char in quality:gmatch"." do
        qual_total = string.byte(char) + qual_total
      end
    return qual_total/#quality
  end

function GC_percentage(sequence)
    local _, G_count = string.gsub(sequence, "G", "")
    local _, C_count = string.gsub(sequence, "C", "")
    -- local _, GC_count = string.gsub(sequence, "/[GCgc]", "")
    return (G_count + C_count)/#sequence*100
  end


function FastqRecord(name, sequence, quality)
    local average_qual = average_qual(quality)
    local GC_percentage = GC_percentage(sequence)
    return {name = name,
            sequence = sequence,
            quality = quality,
            average_qual = average_qual,
            GC_percentage = GC_percentage}
  end

function read_file(path)
    local file = open(path, "rb") 
    if not file then return nil end
    local lines = {}
    for line in file:lines() do 
        lines[#lines + 1] = line
      end
    file:close()
    return lines
  end

lines = read_file('../example.fastq')

print(#lines)

FastqTable = {}
for i = 1, #lines, 4 do
    name = lines[i]
    sequence = lines[i+1]
    quality = lines[i+3]
    -- FastqRecord(name, sequence, quality)
    -- table.insert(FastqTable, FastqRecord(name, sequence, quality))
    FastqTable[#FastqTable+1] = FastqRecord(name, sequence, quality)
  end

print(FastqTable)
-- print(inspect(FastqTable))

-- for i, t in ipairs(FastqTable) do
--     print("\n\n",i)
--     print("name:",t.name)
--     print("sequence:",t.sequence)
--     print("average qual:", t.average_qual)
--   end

-- sort based on average quality
table.sort(FastqTable, function (q1, q2) return q1.average_qual < q2.average_qual end )

for i, val in ipairs(FastqTable) do
    print("\n\n\n")
    print(val.name, "\n",
    val.sequence, "\n",
    val.average_qual, "\n",
    val.GC_percentage)
  end



