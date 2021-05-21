PATH = "/home/mwhalen18/Dropbox (University of Michigan)/R Projects/MovieRecommender"
SCRIPTS_PATH = file.path(PATH, 'scripts')
KEYS_PATH = file.path(PATH, 'scripts/keys')
DATA_PATH = file.path(PATH, 'data')


source(file.path(SCRIPTS_PATH, 'similarity.R'))

streaming = read.csv(file.path(PATH, 'data/streaming.csv'), stringsAsFactors = F)



gimme_something_to_watch = function(movie){
  if(movie %in% titles){
    return(attr(head(sort(m[movie,], decreasing = T),20), "names"))
  } else{
    return("We don't have that movie in our database...Check your spelling/special characters and try again.")
  }
}


join_results = function(movie){
  t = gimme_something_to_watch(movie) %>% as.data.frame()
  if(t[1,] != "We don't have that movie in our database...Check your spelling/special characters and try again."){
    t = as.data.frame(t[-1,])
  }
  colnames(t) = "Title"
  rownames(t) = NULL
  return(left_join(t,streaming) %>% mutate(streaming = ifelse(is.na(streaming), " ", streaming)))
}
