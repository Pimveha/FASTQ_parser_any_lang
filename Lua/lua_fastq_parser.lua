local open = io.open
-- local inspect = require('inspect')

function FastqRecord(name, sequence, quality)
    return { name = name, sequence = sequence, quality = quality }
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

-- array = { FastqRecord("a", "ATGC", "ABCD"), FastqRecord("b", "tTGC", "QBCD") }

-- print(array[1].name)

lines = read_file('../example.fastq')
-- print(lines[2])

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


-- print(FastqTable)
-- print(inspect(FastqTable))