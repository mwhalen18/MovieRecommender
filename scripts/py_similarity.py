import numpy as np
import pandas as pd

from sklearn.metrics.pairwise import cosine_similarity
from sklearn.feature_extraction.text import CountVectorizer

def cosine_matrix():
  mov = pd.read_csv('/home/mwhalen18/Dropbox (University of Michigan)/R Projects/MovieRecommender/data/scraped_data.csv')

  count = CountVectorizer()
  count_matrix = count.fit_transform(mov['bag_of_words'])
  cosine_sim = cosine_similarity(abs(count_matrix), abs(count_matrix))
  return cosine_sim

