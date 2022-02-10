library(httr)
library(rtweet)
library(jsonlite)


# Create Twitter token
vambot_token <- rtweet::create_token(
  app = "vambot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

random <- fromJSON("https://api.vam.ac.uk/v2/objects/search?random=1&page_size=1&images_exist=true")
records <- random$records
names(records)<-gsub("\\_","",names(records))
number <- records$systemNumber
title <- records$primaryTitle
imageID <- records$primaryImageId
imageUrl <- paste0('https://framemark.vam.ac.uk/collections/',imageID,'/full/full/0/default.jpg')
url <- paste0('https://collections.vam.ac.uk/item/',number)
tweet <- paste0(title,' ', url)
temp_file <- tempfile()
download.file(imageUrl, temp_file)

rtweet::post_tweet(
  status = tweet,
  token = vambot_token
)
