library(rvest)
library(dplyr)
library(rlist)
library(purrr)
library(tictoc)
library(furrr)
plan(multisession(workers = 10))
select = dplyr::select
DATA_PATH = "/home/mwhalen18/Dropbox (University of Michigan)/R Projects/MovieRecommender/data"
#NETFLIX####
N_MOVIES = 2500
pages <- seq(0, N_MOVIES, by = 50)
NETFLIX_URL   <- "https://reelgood.com/movies/source/netflix?offset="
HULU_URL      <- "https://reelgood.com/movies/source/hulu?offset="
PRIME_URL     <- "https://reelgood.com/movies/source/amazon?offset="
DISNEY_URL    <- "https://reelgood.com/movies/source/disney_plus?offset="
HBO_URL       <- "https://reelgood.com/movies/source/hbo_max?offset="
APPLE_URL     <- "https://reelgood.com/movies/source/apple_tv?offset="
CRITERION_URL <- "https://reelgood.com/movies/source/criterion_channel?offset="

netflix_pages <- paste0(NETFLIX_URL, pages)
hulu_pages <- paste0(HULU_URL, pages)
prime_pages <- paste0(PRIME_URL, pages)
disney_pages <- paste0(DISNEY_URL, pages)
hbo_pages <- paste0(HBO_URL, pages)
criterion_pages <- paste0(CRITERION_URL, pages)

streamScraper = function(URL){
  temp = read_html(URL) %>% html_nodes("table") %>% .[1] %>% html_table(fill = TRUE, header = TRUE) %>% as.data.frame()
  return(temp)
}

movieCleanup = function(dataframe){
  dataframe = list.rbind(dataframe)
  dataframe = tibble(dataframe[,c(2)])
  colnames(dataframe)= as.character("Title")
  return(dataframe)
}

netflix = furrr::future_map(netflix_pages, function(x){
  streamScraper(x)
}) %>% movieCleanup()

hulu = furrr::future_map(hulu_pages, function(x){
  streamScraper(x)
}) %>% movieCleanup()

prime = furrr::future_map(prime_pages, function(x){
  streamScraper(x)
}) %>% movieCleanup()

disney = furrr::future_map(disney_pages, function(x){
  streamScraper(x)
}) %>% movieCleanup()

hbo = furrr::future_map(hbo_pages, function(x){
  streamScraper(x)
}) %>% movieCleanup()

criterion = furrr::future_map(criterion_pages, function(x){
  streamScraper(x)
}) %>% movieCleanup()

netflix$netflix = as.character("netflix")
hulu$hulu = as.character("hulu")
prime$prime = as.character("prime")
disney$disney = as.character("disney")
hbo$hbo = as.character("hbo")
criterion$criterion = as.character("criterion")

Titles = cbind(netflix$Title, hulu$Title)
temp = full_join(netflix, hulu) %>%
  full_join(., hbo) %>% 
  full_join(., prime) %>%
  full_join(., disney) %>%
  full_join(criterion)


Streaming = temp %>% 
  mutate(across(everything(), function(x){
    ifelse(is.na(x), "", x)
  }),
  streaming = paste0(netflix, " ", hulu, " ", hbo, " ", prime, " ", disney, " ", criterion)) %>%
  select(Title, streaming)

write.csv(Streaming, file.path(DATA_PATH, 'streaming.csv'), row.names = F)
