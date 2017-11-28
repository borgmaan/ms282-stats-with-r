library(rvest)
library(dplyr)


bond.url <-  "https://en.wikipedia.org/w/index.php?title=List_of_James_Bond_films&oldid=688916363"
bond.wiki <- read_html(bond.url)

## film data
bond.films <- bond.wiki %>%
  html_nodes("table") %>%
  .[[1]] %>%
  html_table(fill = TRUE)

# lots of cleaning to work to be done now...
bond.films %<>% 
  # make clean column names (replace space with dot)
  setNames(make.names(names(bond.films), unique = TRUE)) %>% 
  # remove first and last line (inner-table headers)
  head(-1) %>% tail(-1) %>% 
  mutate(
    # clean wiki-related data import problems
    Title = f.clean.titles(Title),
    Bond.actor = f.clean.double.names(Bond.actor), 
    Director = f.clean.double.names(Director),
    # NA coerced here are what we want -- ignore the warnings
    Box.office = as.numeric(f.clean.footnote.marks(Box.office)),
    Budget = as.numeric(f.retrieve.initial.numbers(Budget)), 
    Salary.of.Bond.actor = as.numeric(f.retrieve.initial.numbers(Salary.of.Bond.actor)),
    # rename the 2005 adjusted price values
    Box.office.2005.adj = as.numeric(Box.office.1), 
    Budget.2005.adj = as.numeric(Budget.1), 
    Salary.of.Bond.actor.2005.adj = as.numeric(f.retrieve.initial.numbers(Salary.of.Bond.actor.1)), 
    RoI = Box.office.2005.adj/Budget.2005.adj
  ) %>% 
  # remove old uninformative uniqueness naming
  select(-contains("1"))

