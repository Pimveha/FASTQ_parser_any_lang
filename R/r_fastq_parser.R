lines <- readLines("../example.fastq")

content_list = c("name", "sequence", "ignore", "quality")
length(rep(content_list, times = length(lines)/4))
length(lines)
length(rep(1:(length(lines)/4), each = 4))
# seq(0, length(lines), by=4) 
# rep(1:4, c(4,4,4,4))
# 
# rep_times = rep(4, length(lines)/4)
# ?rep
# 
# rep(1:4, each = 4)
# 
# rep(1:length(lines), each = 4)
# rep(1:length(lines), 4)
# rep(1:length(lines), c(4,4,4,4))
?seq


df_lines <- data.frame(fastq_content = lines,
                       id = rep(1:(length(lines)/4), each = 4),
                       id_content = rep(content_list, times = length(lines)/4))

df_lines[df_lines$id == 1,]

# rownames(df_lines) <- c()
  
# paste0(rep(mynames,length.out=6587),rep(1:366,each=18,length.out=6587))