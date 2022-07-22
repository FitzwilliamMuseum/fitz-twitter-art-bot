library(httr)
library(rtweet)
library(jsonlite)
random <- fromJSON("https://data.fitzmuseum.cam.ac.uk/random")
contentUrl <- 'https://data.fitzmuseum.cam.ac.uk/imagestore/'
uri <- gsub("http","https",random$admin$uri)
accession <- as.list(random$identifier$accession_number)
number <- accession[1]
images <- random$multimedia$processed
imageLarge <- images$large$location[1:1]
imageUrl <- paste0(contentUrl,imageLarge)

makers <-as.data.frame(random$lifecycle$creation$maker)
maker <- paste(c(paste(rev(strsplit(gsub(',','',makers$summary_title), "\\s+")[[1]]), collapse= " ")),collapse=' & ' )


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
print(tweetText)
print(label)
# Create Twitter token

fitzArtBot_token <- rtweet::rtweet_bot(
  api_key =    Sys.getenv("TWITTER_CONSUMER_API_KEY"),
  api_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token =    Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret =   Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)
rtweet::auth_as(fitzArtBot_token)

rtweet::post_tweet(
  status = tweetText,
  media = temp_file,
  media_alt_text = label
)
