JHU Coursera Data Science     
Capstone Project
"SwifterKey"
========================================================
author: Brett Wiens
date: March 23, 2018
autosize: true

Summary
========================================================

The aim of this project was to create an application which would mine a large body of text taken from Twitter, blogs and news feeds in order to quickly and efficiently predict the next word likely to be input by a user.

Features:

* No Submit Button: The application processes the entirety of the corpus on-the-fly and produces immediate predictions
* Low Frequency Results: Dynamic predictions for any text combination that occurred more than once in the corpus.
* Dynamic Buttons: Instead of typing, the user can just click the top 5 predicted words and auto-generate an entire story.
* Flexible Predictions: The user can elect to predict between 5 and 50 predictions (top 5 are buttonized)
* 100% Corpus: The predictions are based on the entire dataset, maximum predictive capability.

Data Prep
========================================================

* The analysis begins with a large body of literature gathered from Blogs, Twitter and News feeds.
* The entire body was combined and tokenized (broken into single words and then recombined for prediction).
* Profanities and non-word characters were removed. (Punctuation, apostrophes, numbers, etc.).
* tokens were combined into n-grams (1, 2, 3, 4, and 5 word combinations).
* for each n-gram, the last word (trained prediction), was separated from the other(s) (predictors).

n-Gram examples:  

```
   nGram            Example      Predictor Prediction
1 2-gram               I am              I         am
2 3-gram           I am the          I am         the
3 4-gram     I am the first       I am the      first
4 5-gram I am the first one I am the first        one
```

Predictions
========================================================

- Predictions are created by taking the predictor words from the text provided by the user.
- The number of words are calculated by splitting the input at each space.
- If there are sufficient words (4) first the 5-gram prediction is checked, any matches are returned.
- If the user has asked for more results than returned by the 5-gram, or there aren't sufficient words, the algorithm repeats and checks the 4-grams
- The algorithm decreases the nGram until a sufficient number of predictions are returned.
- If the final word is not in the corpus, the algorithm predicts the ten most frequent words (The, And, I...)

User Interface
========================================================

The User Interface is comprised of four key elements:
<br>
1. <img src = "www/InputText.png" width = 250, height = 120>
2. <img src = "www/PredictionNumber.png" width = 250, height = 120>
3. <img src = "www/Top5.png" width = 250, height = 120>
4. <img src = "www/PredictTable.png" width = 250, height = 120>
<br>
- 1.  Text Input: The user is prompted to provide some text upon which to base the predictions.
- 2.  Number of Predictions: The user provides the desired number of predictions (5-50)
- 3.  Top 5 Dynamic Buttons: The most frequent 5 word predictions are presented, and the user can simply click those buttons to add them to the text.
- 4.  The table of predictions: Shows all of the predicted values up to the number specified by the user on the slider.

There is also a full documentation tab to explain how this works complete with pictures.
