library(reticulate)

select = dplyr::select

PATH = "/home/mwhalen18/Dropbox (University of Michigan)/R Projects/MovieRecommender"
SCRIPTS_PATH = file.path(PATH, 'scripts')
KEYS_PATH = file.path(PATH, 'scripts/keys')
DATA_PATH = file.path(PATH, 'data')


reticulate::source_python(file.path(SCRIPTS_PATH, 'py_similarity.py'))

titles = read.csv(file.path(DATA_PATH, 'scraped_data.csv'))
titles = titles$original_title

m = cosine_matrix()
rownames(m) = titles
colnames(m) = titles
