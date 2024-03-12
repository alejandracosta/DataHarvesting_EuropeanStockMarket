# R Script to execute with taskscheduler

# Libraries
library(scrapex)
library(rvest)
library(dplyr)
library(taskscheduleR)
library(scrapex)
library(rvest)
library(httr)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(tools)
library(taskscheduleR)

timestamp <- format(Sys.time(), "%Y%m%d_%H%M%S") 


### World_Index

link_index <- "https://es.finance.yahoo.com/world-indices/"
index <- read_html(link_index)

all_tables <- index %>%
  html_nodes("table") %>%
  html_table() %>% 
  print()

index_table <-  all_tables[[1]] %>% 
  print()

index_table <-  index_table %>% select_if(is.character) 

index_table <-
  index_table %>% 
  mutate(
      Símbolo = str_replace_all(string = Símbolo, pattern = "\\^", replacement = ""),
      Date = timestamp <- format(Sys.time(), "%H:%M")) %>% 
        print()
      

column_names <- colnames(index_table)
column_names <- str_replace_all(column_names, pattern = "[íÍ]", replacement = "i")
column_names <- str_replace_all(column_names, pattern = "[úÚ]", replacement = "U")
column_names <- str_replace_all(column_names, pattern = " ", replacement = "_")
colnames(index_table) <- column_names
print(index_table)





### IBEX-35

link_ibex <- "https://es.investing.com/indices/spain-35-components"
ibex <- read_html(link_ibex)

all_tables <-  ibex %>%  
  html_table() %>% 
  print()      
table_ibex <- all_tables %>% 
  .[[2]] %>%
  print()
table_ibex<-table_ibex  %>%  
  select(c(2:9)) %>% 
  mutate(country="Spain") %>% 
  print()

column_names <- colnames(table_ibex)
column_names <- str_replace_all(column_names, pattern = "[áÁ]", replacement = "a")
column_names <- str_replace_all(column_names, pattern = "[éÉ]", replacement = "e")
column_names <- str_replace_all(column_names, pattern = "[íÍ]", replacement = "i")
column_names <- str_replace_all(column_names, pattern = "[óÓ]", replacement = "o")
column_names <- str_replace_all(column_names, pattern = "[úÚ]", replacement = "u")
column_names <- str_replace_all(column_names, pattern = " ", replacement = "_")
colnames(table_ibex) <- column_names

print(table_ibex)



### DAX - Germany
link_dax <- "https://es.investing.com/indices/germany-30-components"
dax <- read_html(link_dax)
all_tables_dax <- dax %>%  
  html_table() %>% 
  print() 
table_dax<- all_tables_dax %>% 
  .[[2]] %>%
  print()
table_dax<-table_dax %>%  
  select(c(2:9)) %>% 
  mutate(country="Germany")
table_dax

column_names <- colnames(table_dax)
column_names <- str_replace_all(column_names, pattern = "[áÁ]", replacement = "a")
column_names <- str_replace_all(column_names, pattern = "[éÉ]", replacement = "e")
column_names <- str_replace_all(column_names, pattern = "[íÍ]", replacement = "i")
column_names <- str_replace_all(column_names, pattern = "[óÓ]", replacement = "o")
column_names <- str_replace_all(column_names, pattern = "[úÚ]", replacement = "u")
column_names <- str_replace_all(column_names, pattern = " ", replacement = "_")
colnames(table_dax) <- column_names



### CAC - France
link_cac <- "https://es.investing.com/indices/france-40-components"
cac <- read_html(link_cac)

all_tables_cac <- cac %>%  
  html_table() %>% 
  print() 

table_cac<- all_tables_cac %>% 
  .[[2]] %>%
  print()

table_cac<-table_cac  %>%  
  select(c(2:9)) %>% 
  mutate(country="France")

column_names <- colnames(table_cac)
column_names <- str_replace_all(column_names, pattern = "[áÁ]", replacement = "a")
column_names <- str_replace_all(column_names, pattern = "[éÉ]", replacement = "e")
column_names <- str_replace_all(column_names, pattern = "[íÍ]", replacement = "i")
column_names <- str_replace_all(column_names, pattern = "[óÓ]", replacement = "o")
column_names <- str_replace_all(column_names, pattern = "[úÚ]", replacement = "u")
column_names <- str_replace_all(column_names, pattern = " ", replacement = "_")
colnames(table_cac) <- column_names


table_cac

### FTSE - United Kingdom
link_ftse <- "https://es.investing.com/indices/investing.com-uk-100-components"
ftse<- read_html(link_ftse)

all_tables_ftse <- ftse %>%  
  html_table() %>% 
  print() 

table_ftse<- all_tables_ftse %>% 
  .[[1]] %>%
  print()

table_ftse<-table_ftse %>% 
  select(c(2:9)) %>% 
  mutate(country="United Kingdom")

column_names <- colnames(table_ftse)
column_names <- str_replace_all(column_names, pattern = "[áÁ]", replacement = "a")
column_names <- str_replace_all(column_names, pattern = "[éÉ]", replacement = "e")
column_names <- str_replace_all(column_names, pattern = "[íÍ]", replacement = "i")
column_names <- str_replace_all(column_names, pattern = "[óÓ]", replacement = "o")
column_names <- str_replace_all(column_names, pattern = "[úÚ]", replacement = "u")
column_names <- str_replace_all(column_names, pattern = " ", replacement = "_")
colnames(table_ftse) <- column_names


table_ftse



### ATX - Austria
link_atx <- "https://es.investing.com/indices/atx-components"
atx<- read_html(link_atx)

all_tables_atx <- atx %>%  
  html_table() %>%
  print()

table_atx <- all_tables_atx %>%
  .[[1]] %>%
  print()

table_atx <- table_atx  %>% 
  select(c(2:9))  %>% 
  mutate(country="Austria")


column_names <- colnames(table_atx)
column_names <- str_replace_all(column_names, pattern = "[áÁ]", replacement = "a")
column_names <- str_replace_all(column_names, pattern = "[éÉ]", replacement = "e")
column_names <- str_replace_all(column_names, pattern = "[íÍ]", replacement = "i")
column_names <- str_replace_all(column_names, pattern = "[óÓ]", replacement = "o")
column_names <- str_replace_all(column_names, pattern = "[úÚ]", replacement = "u")
column_names <- str_replace_all(column_names, pattern = " ", replacement = "_")
colnames(table_atx) <- column_names

table_atx


### BEL20 - Belgium
link_bel<- "https://es.investing.com/indices/bel-20-components"
bel<- read_html(link_bel)

all_tables_bel <-bel %>%  
  html_table() %>% 
  print() 

table_bel<- all_tables_bel %>% 
  .[[2]] %>%
  print()

table_bel <- table_bel %>% 
  select(c(2:9)) %>%  
  mutate(country="Belgium")

column_names <- colnames(table_bel)
column_names <- str_replace_all(column_names, pattern = "[áÁ]", replacement = "a")
column_names <- str_replace_all(column_names, pattern = "[éÉ]", replacement = "e")
column_names <- str_replace_all(column_names, pattern = "[íÍ]", replacement = "i")
column_names <- str_replace_all(column_names, pattern = "[óÓ]", replacement = "o")
column_names <- str_replace_all(column_names, pattern = "[úÚ]", replacement = "u")
column_names <- str_replace_all(column_names, pattern = " ", replacement = "_")
colnames(table_bel) <- column_names

table_bel







# WARNING: Replace the provided path with your current working directory path, keeping the last part. Your code should look as follows: 
# write.csv(index_table, paste0("C:/PATH/TO/YOUR/FILE/world_index", timestamp, ".csv"), row.names = FALSE)

write.csv(index_table, paste0("C:/Users/aleco/OneDrive/Documentos/Master CSS/Data Harvesting/Data/world_index", timestamp, ".csv"), row.names = FALSE)
write.csv(table_ibex, paste0("C:/Users/aleco/OneDrive/Documentos/Master CSS/Data Harvesting/Data/ibex_", timestamp, ".csv"), row.names = FALSE)
write.csv(table_dax, paste0("C:/Users/aleco/OneDrive/Documentos/Master CSS/Data Harvesting/Data/dax_", timestamp, ".csv"), row.names = FALSE)
write.csv(table_cac, paste0("C:/Users/aleco/OneDrive/Documentos/Master CSS/Data Harvesting/Data/cac_", timestamp, ".csv"), row.names = FALSE)
write.csv(table_ftse, paste0("C:/Users/aleco/OneDrive/Documentos/Master CSS/Data Harvesting/Data/ftse_", timestamp, ".csv"), row.names = FALSE)
write.csv(table_atx, paste0("C:/Users/aleco/OneDrive/Documentos/Master CSS/Data Harvesting/Data/atx_", timestamp, ".csv"), row.names = FALSE)
write.csv(table_bel, paste0("C:/Users/aleco/OneDrive/Documentos/Master CSS/Data Harvesting/Data/bel_", timestamp, ".csv"), row.names = FALSE)