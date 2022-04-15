# Fitzwilliam Museum Twitter Bot - random Art work

[![DOI](https://zenodo.org/badge/457719564.svg)](https://zenodo.org/badge/latestdoi/457719564) [![ORCiD](https://img.shields.io/badge/ORCiD-0000--0002--0246--2335-green.svg)](http://orcid.org/0000-0002-0246-2335)

This twitter bot runs from a simple R script. This script
polls a random json endpoint from the collection database and
then assembles a tweet with:

* Link to record
* An image of the artwork
* The title(s) of the artwork
* The maker(s) of the artwork
* Accession number

This currently pulls just from the works in Prints and Drawings with a picture
attached, this may change.

The bot tweets at https://twitter.com/fitzArtBot 

## How this works

To make this work, a Twitter App needs to be generated with elevated access to the V2 API (read and write) - apply for access from essential after generation.
Once you have set up the twitter account, you need to set the 4 keys referred to in the R script as secrets in the github repo settings. Then the action will be executed every 6 hours and send a tweet.

The endpoint from which JSON is retrieved can be found at https://data.fitzmuseum.cam.ac.uk/random and is also used to run https://random.fitzmuseum.cam.ac.uk 

## License

GPL V3 for code 
Content within the Fitz API that this calls data from is CC-0 for metadata, CC-BY-NC-ND for images. 
