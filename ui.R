#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny); library(dplyr); library(ggplot2); library(shinythemes)

# Define UI for application that draws a histogram
fluidPage(theme = shinytheme("slate"),

  # Application title
  titlePanel("SwifterKey"),
  h3("JHU Coursera - Data Science Capstone Project"),
  h4("Brett Wiens - March 23, 2018"),
  br(),
  tabsetPanel(
  tabPanel("Text Prediction",
     fluidRow(
       # column(1),
       column(8, wellPanel(
              # h4("Type the text to receive predictions"),

       textInput("user_text",
                 "Type something to predict the next word:",
                 "",
                 width = '100%')
       )),
       column(4 , wellPanel(
            sliderInput("number_predictions",
                        "How many predictions?",
                        min = 5, max = 50, value = 10)
       )) 
  ),
  fluidRow(
       column(12, wellPanel(
            h4("Click a button to add one of the top 5 predicted words:"),
            actionButton("predict1", label = prediction1, width = '19%', style = "color: #000000; background-color: #FFA0A0; border-color: #000000"),
            actionButton("predict2", label = prediction2, width = '19%', style = "color: #000000; background-color: #FFC470; border-color: #000000"),
            actionButton("predict3", label = prediction3, width = '19%', style = "color: #000000; background-color: #FDFF70; border-color: #000000"),
            actionButton("predict4", label = prediction4, width = '19%', style = "color: #000000; background-color: #70FF90; border-color: #000000"),
            actionButton("predict5", label = prediction5, width = '19%', style = "color: #000000; background-color: #A0A3FF; border-color: #000000")
       ))
       
  ),
  hr(),
  fluidRow(
       h3("Prediction Explanation Table:"),
       dataTableOutput("predictionTable")
     )
), 
tabPanel("Documentation",
          fluidRow(
               hr(),
               h4("Input Text"),
               img(src='InputText.png', align = "left"),
               p("Here the user is asked to provide a string of text for which the application will predict the next word.  The string can be of any length, but the last (up to) four words will be used to create the prediction.")
          ),
          fluidRow(
               hr(),
               h4("Number of Predictions"),
               img(src='PredictionNumber.png', align = "left"),
               p("The user may ask the application to predict as few as five words, or as many as fifty.  Only the top five will be presented to the prediction buttons below, but all fifty will show in the table.")
          ),
          fluidRow(
               hr(),
               h4("Top Five Prediction Buttons"),
               img(src='Top5.png', align = "left"),
               p("The application analyzes the input text string and identifies the five most likely candidates for the next word.  These are presented as buttons which can be used to automatically add the next word to the input string and repeat.")
          ),
          fluidRow(
               hr(),
               h4("Prediction Table"),
               img(src="PredictTable.png", align = "left"),
               p("The entirety of the results of the analysis are presented here.  Depending on the user's selected number of predictions and the input text, all predicted next words will be shown.")
       ))
)
)
