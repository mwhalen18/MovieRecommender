library(twitteR)
library(rvest)
library(jpeg)
library(rtweet)
library(stringr)
library(gridExtra)
library(dplyr)
library(glue)

'%notin%' = Negate('%in%')


PATH = "/home/mwhalen18/Dropbox (University of Michigan)/R Projects/MovieRecommender"
SCRIPTS_PATH = file.path(PATH, 'scripts')
KEYS_PATH = file.path(PATH, 'scripts/keys')
DATA_PATH = file.path(PATH, 'data')
FILES_PATH = file.path(PATH, 'files')


source(file.path(KEYS_PATH, 'twitter_keys.R'))
source(file.path(SCRIPTS_PATH, "stream_scrape_join.R"))
#need both rtweet and twitteR
#rtweet::create_token(consumer_key = api_key,
#                     consumer_secret = api_secret,
#                     access_token = access_token,
#                     access_secret = access_secret)
options(httr_oauth_cache = TRUE)
setup_twitter_oauth(consumer_key = api_key,
                    consumer_secret = api_secret,
                    access_token = access_token,
                    access_secret = access_secret)


getRandomMovie = function(){
  return(as.character(sample(titles, size = 1)))
}
rando = getRandomMovie()

message = glue("Looking for something to watch? Check out {rando} or one of these similar movies!")
df = join_results(rando)

jpeg("temp.jpeg", height = 25*nrow(df), width = 350) #the next few lines just prepare R to store the table as a temprary JPEG
grid.table(df)
dev.off() #this line saves a temporary JPEG

rtweet::post_tweet(status = message, media = "temp.jpeg")

