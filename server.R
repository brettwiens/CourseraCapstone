#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny); library(beepr)

# Define server logic required to draw a histogram
shinyServer(
     

     
     function(input, output, clientData, session) {
          
          ## Predictions need to be reactive so that they carry through the observations and are maintained.
          predictions <- reactiveValues(prediction1 = "The", prediction2 = "To", prediction3 = "And", prediction4 = "A", prediction5 = "I")

          ## ===========================================================
          ## Main Data Processing and Analysis
          ## ===========================================================
          
          observe({
               testString <- input$user_text          ## Pull the text string from the text box on the UI
               predictionSize <- input$number_predictions
               TextPrediction <- data.frame(matrix(ncol = 3, nrow = 0))
               
               if(length(testString) > 0){TextPrediction <- 
                    predictWords(testString, predictionSize, TextPrediction, prediction1, prediction2, prediction3, prediction4, prediction5)
               
                    predictions$prediction1 <- TextPrediction[1,2]
                    predictions$prediction2 <- TextPrediction[2,2]
                    predictions$prediction3 <- TextPrediction[3,2]
                    predictions$prediction4 <- TextPrediction[4,2]
                    predictions$prediction5 <- TextPrediction[5,2]
                    
                    ## Take the five most likely predictions and store those values to the action button
                    updateActionButton(session, "predict1", label = predictions$prediction1)
                    updateActionButton(session, "predict2", label = predictions$prediction2)
                    updateActionButton(session, "predict3", label = predictions$prediction3)
                    updateActionButton(session, "predict4", label = predictions$prediction4)
                    updateActionButton(session, "predict5", label = predictions$prediction5)
                    
                    # TextPrediction <- TextPrediction[,c(1,2,3)]
                    # TextPrediction$Probability <- paste(round(TextPrediction$n/sum(TextPrediction$n),digits = 4) * 80, "%", sep = "")
                    
                    output$predictionTable <- renderDataTable(TextPrediction, 
                                                              options = list(lengthMenu = c(5, input$number_predictions), 
                                                                             pageLength = max(5, input$number_predictions)))
               }
          })
          
          ## ===========================================================
          ## User Interface Interactions (Action Button Handling)
          ## ===========================================================
          
          ## If the user clicks on the first action Button (predict1) the input text string adds the value from that button to the input string
          observeEvent(input$predict1,{
               updateTextInput(session, "user_text", value = paste(input$user_text,predictions$prediction1))
          })
          ## If the user clicks on the second action Button (predict2) the input text string adds the value from that button to the input string
          observeEvent(input$predict2,{
               updateTextInput(session, "user_text", value = paste(input$user_text,predictions$prediction2))
          })
          ## If the user clicks on the third action Button (predict3) the input text string adds the value from that button to the input string
          observeEvent(input$predict3,{
               updateTextInput(session, "user_text", value = paste(input$user_text,predictions$prediction3))
          })
          ## If the user clicks on the fourth action Button (predict4) the input text string adds the value from that button to the input string
          observeEvent(input$predict4,{
               updateTextInput(session, "user_text", value = paste(input$user_text,predictions$prediction4))
          })
          ## If the user clicks on the fifth action Button (predict5) the input text string adds the value from that button to the input string
          observeEvent(input$predict5,{
               updateTextInput(session, "user_text", value = paste(input$user_text,predictions$prediction5))
          })

})

