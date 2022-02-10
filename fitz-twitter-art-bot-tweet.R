library(httr)
library(rtweet)
library(jsonlite)
random <- fromJSON("https://data.fitzmuseum.cam.ac.uk/random")
contentUrl <- 'https://data.fitzmuseum.cam.ac.uk/imagestore/'
uri <- gsub("http","https",random$admin$uri)
accession <- as.list(random$identifier$accession_number)
number <- accession[1]
images <- random$multimedia$processed
imageLarge <- images$large$location
imageUrl <- paste0(contentUrl,imageLarge)

makers <-as.data.frame(random$lifecycle$creation$maker)
maker <- paste(c(makers$summary_title),collapse=' & ' )

title <- random$summary_title

fullTitles <- paste(c(random$title$value),collapse=', ' )

acquistion <- as.data.frame(random$lifecycle$acquisition$date)

if(title != fullTitles){
  label <- paste(fullTitles,'-',title,sep = ' ')
} else {
  label <- fullTitles
}
tweetText <- paste(number, label, 'made by', maker, uri, 'Acquired', acquistion[, c('value')], sep=' ')
temp_file <- tempfile()
download.file(imageUrl, temp_file)
# Create Twitter token
fitzArtBot_token <- rtweet::create_token(
  app = "fitzArtBot",
  consumer_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)
rtweet::post_tweet(
  status = tweet,
  token = fitzArtBot_token
)
