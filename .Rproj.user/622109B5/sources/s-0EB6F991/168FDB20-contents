getTMDbIDs = function(n = 6000){
  pages = seq(1,n/20, by = 1)
  results = list()
  for(i in 1:max(pages)){
    results[[i]] = discover_movie(api_key, language = 'en', sort_by = 'vote_count.desc', page = i)$results$id
  }
  ids = unlist(results)
  return(ids)
}

load(file.path(DATA_PATH, 'departments.rda'))

collapseNames = function(list_element){
  gsub(","," ", gsub(" ", "", paste(list_element, collapse = ",")))
}


movieMaker = function(id, departments){
  m = movie(api_key, id, append_to_response = c("credits, keywords"))
  df = m
  df$genres = m$genres$name      
  df$production_companies = m$production_companies$name
  df$production_countries = m$production_countries$name
  df$belongs_to_collection = NULL
  df$spoken_languages = m$spoken_languages$english_name
  df$cast = m$credits$cast[m$credits$cast$order %in% sort(head(m$credits$cast$order, 6)),]$name
  df$crew = m$credits$crew
  df$credits = NULL
  df$keywords = m$keywords$keywords$name
  
  for(department in departments){
    df[[department]] = collapseNames(
      unique(m$credits$crew[m$credits$crew$department == department, ]$name[1:4]))
  }
  
  df$crew = NULL
  fixers = c('genres', 'production_companies', 'production_countries')
  for(i in 1:length(df)){
    if(length(df[[i]]) > 1 | names(df)[[i]] %in% fixers){
      df[[i]] = collapseNames(df[[i]])
    } else if(length(df[[i]]) ==0){
      df[[i]] = NA
    }
  }
  return(df)
}
