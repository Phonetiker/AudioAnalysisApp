##############################################################
## This is the server portion of shiny app that allows the 
## user to choose from a selection of audio files and display 
## plots of waveforms and spectrograms of them. The user can 
## also select a window size, allowing them to opt for better 
## frequency resolution (larger window) or a better 
## temporal resolution (smaller window).
##
## All audio files were originally downloaded from http://www.wavsource.com/
##
## (CC) Stephen Tobin, May 2016
##############################################################

## Load the required packages
require(shiny)
require(seewave)
require(tuneR)

## Furnish the workspace with the necessary data 
## Check if the audio files are already in the workspace
if(!(exists("dog")) | !exists("cat") | 
   !(exists("bird")) | !exists("mwow") | 
   !exists("msacrebleu") | !exists("mgroovy") | 
   !exists("fhi") | !exists("fecoutemoi") | 
   !exists("ffun")) {

## Check if the audio files are available within the working directory        
        if(!(file.exists("./audiosamples/cat_y.wav")) | !exists("./audiosamples/dog_bark_x.wav") | 
           !exists("./audiosamples/hawk.wav") | !exists("./audiosamples/wow.wav") | 
           !exists("./audiosamples/sacre.wav") | !exists("./audiosamples/groovy.wav") | 
           !exists("./audiosamples/hi.wav") | !exists("./audiosamples/ecoute.wav") | 
           !exists("./audiosamples/fun.wav")) {

## Check if the zip folder of audio files is in the working directory                                
## Download the zip folder if it is not there                
                if(!(file.exists("audiosamples.zip"))) {
                        fileURL <- "https://dl.dropboxusercontent.com/s/4bgscby25yi7xun/audiosamples.zip?dl=0"
                        download.file(fileURL, destfile="./audiosamples.zip", mode="wb")
                }

## Unzip the zipped folder if the files are not available within the working directory                                
                unzip("audiosamples.zip", overwrite = TRUE, junkpaths = FALSE, exdir = ".") 
        }
        
## Load the data files into the workspace if they are not already there
        cat <- readWave("./audiosamples/cat_y.wav")
        dog <- readWave("./audiosamples/dog_bark_x.wav")
        bird <- readWave("./audiosamples/hawk.wav")
        mwow <- readWave("./audiosamples/wow.wav")
        msacrebleu <- readWave("./audiosamples/sacre.wav")
        mgroovy <- readWave("./audiosamples/groovy.wav")
        fhi <- readWave("./audiosamples/hi.wav")
        fecoutemoi <- readWave("./audiosamples/ecoute_moi.wav")
        ffun <- readWave("./audiosamples/fun.wav")
}


## Main data processing function 
shinyServer(
    function(input, output) {

## Reactive function to load the relevant audio file into the 
## dynamic variable "get.audio" in response to user input
        get.audio <- reactive({
            switch(input$audio,
                "cat" = cat,
                "dog" = dog,
                "bird" = bird,
                "mwow" = mwow,
                "msacrebleu" = msacrebleu,
                "mgroovy" = mgroovy,
                "fhi" = fhi,
                "fecoutemoi" = fecoutemoi,
                "ffun" = ffun)
        })

## Get file and window length selections from user input
## Display these entries separately from radio buttons
## to cinform user selections
        output$oaudio <- renderPrint({input$audio})
        output$owin <- renderPrint(input$win)

## Create a reactive spectrogram and waveform plot of the selected audio file
## using the user-entered window length 
        output$newSpectrogram <- renderPlot({
            myaudio <- get.audio()
            spectro(myaudio, f=myaudio$sf, wl=as.numeric(input$win), osc=TRUE)
        })
    }
)
