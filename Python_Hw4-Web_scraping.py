#HW4 Clean data from Web scraping
# Web scraping
# library gazpacho

##install new library on google colab
#pip => package manager in Python

!pip install gazpacho
from gazpacho import Soup
import re

#HW4 Clean data from Web scraping

#web scraping basics
url = "https://www.imdb.com/list/ls051211184/"
requests.get(url)
html = requests.get(url)

imdb =Soup(html.text)

titles = imdb.find("h3", {"class":"lister-item-header"})
clean_titles  =[]

##  list comprehension
clean_titles = [re.split(r"\(.+\)$", title.strip())[0] for title in titles]
clean_titles

#get rating
ratings = imdb.find("div",{"class": "ipl-rating-star small"})
#print(ratings[0])
clean_ratings = [rating.strip() for rating in ratings]
clean_ratings

years = imdb.find("span", {"class":"lister-item-year text-muted unbold"})
years[0]
clean_years = [int(re.findall(r"\d{4}", year.strip())[0]) for year in years]
#print(clean_years)

#Create table
import pandas as pd
movie_database  = pd.DataFrame(data= {
    "titles": clean_titles,
    "ratings" : clean_ratings,
    "years" : clean_years
})

movie_database.head()
