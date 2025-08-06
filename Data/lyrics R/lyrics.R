library(tidyverse)

ts_lyrics <- readr::read_csv("ts_lyrics.csv")

glimpse(ts_lyrics)

#About which cities does she sing - and in which songs and albums mostly?

city_counts <- ts_lyrics %>%
  mutate(lyrics = str_to_lower(lyrics)) %>%
  mutate(city_mentioned = case_when(
    str_detect(lyrics, "new york|the city|manhattan") ~ "New York",
    str_detect(lyrics, "london") ~ "London",
    str_detect(lyrics, "paris") ~ "Paris",
    str_detect(lyrics, "los angeles|LA|L.A.") ~ "LA",
    .default = "no city"
  )) %>%
  group_by(`album title`, `song title`, city_mentioned) %>%
  summarize(n = n())

view(city_counts)

#About which colors does she sing the most?

colors <- ts_lyrics %>%
  mutate(lyrics = str_to_lower(lyrics)) %>%
  mutate(colors = case_when(
    str_detect(lyrics, "red") ~ "red",
    str_detect(lyrics, "blue") ~ "blue",
    str_detect(lyrics, "green") ~ "green",
    str_detect(lyrics, "yellow") ~ "yellow",
    str_detect(lyrics, "black") ~ "black",
    str_detect(lyrics, "white") ~ "white",
    str_detect(lyrics, "pink") ~ "pink",
    str_detect(lyrics, "purple") ~ "purple",
    str_detect(lyrics, "grey") ~ "grey",
    str_detect(lyrics, "brown") ~ "brown",
    str_detect(lyrics, "maroon") ~ "maroon",
    str_detect(lyrics, "turquoise") ~ "turquoise",
    str_detect(lyrics, "lilac") ~ "lilac",
    str_detect(lyrics, "gold|golden") ~ "gold",
    str_detect(lyrics, "silver") ~ "silver",
    .default = "no color"
  )) %>%
  group_by(`album title`, `song title`, colors) %>%
  summarize(n = n())

view(colors)


#Are there more happy or more sad songs?

feelings <- ts_lyrics %>%
  mutate(lyrics = str_to_lower(lyrics)) %>%
  mutate(feelings = case_when(
    str_detect(lyrics, "happy|smile|smiling|laugh|laughing") ~ "happy",
    str_detect(lyrics, "sad|cry|crying|tears|pain|ache|aching") ~ "sad",
    .default = "other"
  )) %>%
  group_by(`album title`, `song title`, feelings) %>%
  summarize(n = n())

view(feelings)

#How many are love songs (in a very strict sense)?

lovesongs <- ts_lyrics %>%
  mutate(lyrics = str_to_lower(lyrics)) %>%
  mutate(lovesongs = case_when(
    str_detect(lyrics, "love|heart|marry") ~ "lovesong",
    .default = "no lovesong"
  )) %>%
  group_by(`album title`, `song title`, lovesongs) %>%
  summarize(n = n())

view(lovesongs)

#How often does she sing about being drunk?

drunk <- ts_lyrics %>%
  mutate(lyrics = str_to_lower(lyrics)) %>%
  mutate(drunk = case_when(
    str_detect(lyrics, "drunk|drinking|wine|beer|drinks|alcohol|alcoholic|wasted") ~ "drunk",
    .default = "sober"
  )) %>%
  group_by(`album title`, `song title`, drunk) %>%
  summarize(n = n())

view(drunk)