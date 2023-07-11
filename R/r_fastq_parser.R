lines <- readLines("../example.fastq")

content_list = c("name", "sequence", "ignore", "quality")
# length(rep(content_list, times = length(lines)/4))
# length(lines)
# length(rep(1:(length(lines)/4), each = 4))
?seq


fastq_df <- data.frame(fastq_content = lines,
                       id = rep(1:(length(lines)/4), each = 4),
                       id_content = rep(content_list, times = length(lines)/4))
# fastq_df[fastq_df$id == 2 & fastq_df$id_content == "name" ,]$fastq_content
# startsWith(fastq_df[fastq_df$id == 2 & fastq_df$id_content == "name" ,]$fastq_content, "@") == TRUE
# fastq_df[fastq_df$id == length(lines)/4 & fastq_df$id_content == "name" ,]$fastq_content
if (startsWith(fastq_df[fastq_df$id == length(lines)/4 & fastq_df$id_content == "name" ,]$fastq_content, "@")){
  cat("fastq file was most likely parsed correctly\n\nyou can now use the fastq_df (dataframe).\n examples:\n   fastq_df[fastq_df$id == 1,]\n   fastq_df[fastq_df$id_content == 'name,]")
}else {
  print("parsing failed")
}

fastq_df[fastq_df$id == 1,]
fastq_df[fastq_df$id_content == "name",]

# rownames(fastq_df) <- c()
  
# paste0(rep(mynames,length.out=6587),rep(1:366,each=18,length.out=6587))