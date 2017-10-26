##############################################################
## This is the user interface portion of shiny app that allows 
## the user to choose from a selection of audio files and 
## display plots of waveforms and spectrograms of them. 
## The user can also select a window size, allowing them to 
## opt for better frequency resolution (larger window) or a 
## better temporal resolution (smaller window).
##
## All audio files were originally downloaded from http://www.wavsource.com/
##
## (CC) Stephen Tobin, May 2016
##############################################################

require(shiny)
# require(seewave)
# require(tuneR)

## Create a fluidPage with four panes.
## The top row contains a single pane for the plot 
## (spectrogram and waveform of the audio file)
shinyUI(
    fluidPage(
    
        title = "Audio Spectrogram Resolution Window Length",

        plotOutput('newSpectrogram'),
    
        hr(),

## The bottom row is divided into three columns
        fluidRow(

## In the first pane, users can select one of nine audio files
            column(3,
                h4("Audio File Selector"),
                    radioButtons("audio", "Sound to analyze", 
                        choices = c("Cat: Meow!" = "cat",
                                    "Dog: Woof woof!" = "dog",
                                    "Bird: Shriek!" = "bird",
                                    "Male: Wow!" = "mwow",
                                    "Male: Sacrebleu!" = "msacrebleu",
                                    "Male: Groovy!" = "mgroovy",
                                    "Female: Hi!" = "fhi",
                                    "Female: Ecoute moi!" = "fecoutemoi",
                                    "Female: That was fun!" = "ffun"),
                                    selected = "cat"
                    )
            ),
            
## In the second pane, users can select the window length used for creating
## the spectrogram in the plot above
            column(5,
                h4("Spectrogram Resolution Window Length"),
                    radioButtons("win", "Window length (samples)",
                        choices=c("16" = "16",
                                    "32" = "32",
                                    "64" = "64",
                                    "128" = "128",
                                    "256" = "256",
                                    "512" = "512",
                                    "1024" = "1024",
                                    "2048" = "2048",
                                    "4096" = "4096"),
                                    inline = TRUE,
                                    selected="128"
                    ),
                p("In the lower part of the plot, you can see a ", em("waveform "), 
                    "of the selected sound: this shows the fluctuations in  air 
                    pressure that characterize the sound."),
                p("In the upper (main) part of the plot, you can see a ", em("spectrogram "), 
                  "of the selected sound: this shows how the energy in the sound is  
                  distributed across different frequencies."),
                p("If you choose shorter windows, the spectrogram will be more
                  accurate in the time dimension (x-axis). Longer windows, however, yield
                  greater accuracy in the frequency dimension(y-axis)")
            ),

## In the third pane, users see the filename and window length they 
## have selected as confirmation
            column(2,
                h4("Selected Values"),
                h5("You selected the following audio file: "),
                verbatimTextOutput("oaudio"),
                h5("You selected the following window length: "),
                verbatimTextOutput("owin")
            )
        )
    )
)
