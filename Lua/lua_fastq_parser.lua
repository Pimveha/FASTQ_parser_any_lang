function FastqRecord(name, sequence, score)        -- "Point" object constructor
    return { name = name, sequence = sequence, score = score }   -- Creates and returns a new object (table)
  end

array = { FastqRecord("a", "ATGC", "ABCD"), FastqRecord("b", "tTGC", "QBCD") }

print(array[1].name)