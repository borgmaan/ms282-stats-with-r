#!/usr/bin/env Rscript
# andrew borgman
# scrape all nba draft data from baskeball reference
library(rvest)
library(dplyr)
library(ggplot2)

# cheat and get the header from the first data set we downloaded
my_header <- c("Rk", "Year", "Lg", "Rd", "Pk", "Tm", "Player", "Age", "Pos", 
               "Born", "College", "From", "To", "G", "PTS", "TRB", "AST", "STL", 
               "BLK", "FG%", "2P%", "3P%", "FT%", "WS", "WS/48")

all_draft_results <- do.call(rbind, lapply(seq(0, 10000, 100), function(i) {
  
  e <- try({
    url <- paste0('http://www.basketball-reference.com/play-index/draft_finder.cgi?request=1&year_min=1947&year_max=2015&round_min=&round_max=&pick_overall_min=&pick_overall_max=&franch_id=&college_id=0&is_active=&is_hof=&pos_is_g=Y&pos_is_gf=Y&pos_is_f=Y&pos_is_fg=Y&pos_is_fc=Y&pos_is_c=Y&pos_is_cf=Y&c1stat=&c1comp=gt&c1val=&c2stat=&c2comp=gt&c2val=&c3stat=&c3comp=gt&c3val=&c4stat=&c4comp=gt&c4val=&order_by=ws&order_by_asc=&offset=', i)
    res <- read_html(url)
    
    tds <- res %>% 
      html_nodes('td') %>% 
      html_text()
    
    beg <- grep('Additional Criteria', x = tds) 
    tds <- tds[-(1:beg)]
    mat <- matrix(tds, ncol = length(my_header), byrow = T)
    
  })
  
  if (inherits(e, 'try-error')) mat <- NULL
  
  Sys.sleep(4) # so our IP doesn't get blocked...
  
  mat  
}))

colnames(all_draft_results) <- my_header
all_draft_results_df <- data.frame(all_draft_results, check.names = FALSE, 
                                   stringsAsFactors = FALSE)

saveRDS(object = all_draft_results_df, 'bball/all-draft-results.rds')

all_draft_results_df <- readRDS(file = 'bball/all-draft-results.rds')


bak <- readRDS(file = 'bball/all-draft-results.rds')

# cast necesarry values to numeric
num_vals <- c("Rk", "Year", "Rd", "Pk", "Age", 
              "From", "To", "G", "PTS", "TRB", "AST", "STL", 
               "BLK", "FG%", "2P%", "3P%", "FT%", "WS", "WS/48")
anac <- function(x) as.numeric(as.character(x))
for (x in num_vals) all_draft_results_df[[x]] <- anac(all_draft_results_df[[x]])


# filter to only include NBA draft results after 1965 when the modern 
# draft was instituted
nba <- all_draft_results_df %>% filter(Lg == 'NBA' & Year > 1965)


  
ggplot(nba, aes(x = Pk, y = WS)) + 
  geom_point() + facet_wrap(~Year)


ggplot(nba, aes(x = Pk, y = `WS/48`)) + 
  geom_point() + facet_wrap(~Year)

ggplot(nba, aes(x = Pk, y = PTS)) + 
  geom_point() + facet_wrap(~Year) + 
  geom_smooth(method = "lm")


ggplot(nba, aes(x = Pk, y = TRB)) + 
  geom_point() + facet_wrap(~Year) + 
  geom_smooth(method = "lm")



ggplot(nba, aes(x = `2P%`, y = PTS)) + 
  geom_point() + 
  geom_smooth(method = "lm")




ll <- read.delim('hanford.txt')

kk <- read.delim('http://www.stat.ncsu.edu/research/sas/sicl/data/human.dat', header = F)


