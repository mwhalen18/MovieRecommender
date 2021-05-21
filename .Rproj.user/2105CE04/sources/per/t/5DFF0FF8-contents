library(TMDb)
library(dplyr)
library(readr)
library(tictoc)
library(furrr) #for multithreading
library(parallel)
parallel::detectCores()
plan(multisession(workers = 10))

select = dplyr::select

PATH = "/home/mwhalen18/Dropbox (University of Michigan)/R Projects/MovieRecommender"
SCRIPTS_PATH = file.path(PATH, 'scripts')
KEYS_PATH = file.path(PATH, 'scripts/keys')
DATA_PATH = file.path(PATH, 'data')

source(file.path(KEYS_PATH, 'tmdb_keys.R'))
source(file.path(SCRIPTS_PATH, 'tmdb_helpers.R'))

ids = getTMDbIDs(n=6000)
movies = list()

tic()
movies = furrr::future_map(ids, function(x){
  tryCatch({
    movieMaker(x,departments)}, error = function(e){})
})
toc()


movies = bind_rows(movies)
movies$bag_of_words = paste(movies$Directing, movies$genres, movies$production_companies,
                            movies$keywords, movies$cast)


write.csv(movies, file.path(DATA_PATH, 'scraped_data.csv'), row.names = F)
