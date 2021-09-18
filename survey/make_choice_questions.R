# Make conjoint surveys using the conjointTools package

# Install packages
# install.packages("remotes")
# install.packages("tidyverse")
# remotes::install_github("jhelvy/conjointTools")

# Load libraries
library(conjointTools)
library(tidyverse)

# Define the attributes and levels
levels <- list(
    type      = c('Fuji', 'Gala', 'Honeycrisp', 'Pink Lady', 'Red Delicious'),
    price     = seq(1, 4, 0.5), # $ per pound 
    freshness = c('Excellent', 'Average', 'Poor')
)

# Make a full-factorial design of experiment
doe <- makeDoe(levels)
head(doe) # preview

# Recode the design of experiment
doe <- recodeDesign(doe, levels)
head(doe) # preview

# Make a basic survey
survey <- makeSurvey(
    doe       = doe,  # Design of experiment
    nResp     = 2000, # Total number of respondents (upper bound)
    nAltsPerQ = 3,    # Number of alternatives per question
    nQPerResp = 8     # Number of questions per respondent
)
head(survey) # preview

# Add image names matched to the apple type 
# (we'll use these to display images in the survey)
image_names <- data.frame(
    type = c('Fuji', 'Gala', 'Honeycrisp', 'Pink Lady', 'Red Delicious'),
    image = c('fuji.jpg', 'gala.jpg', 'honeycrisp.jpg', 'pinkLady.jpg', 
          'redDelicious.jpg')
)
survey <- survey %>% 
    left_join(image_names, by = "type")
head(survey) # preview

# Save design
write_csv(survey, file.path('survey', 'choice_questions.csv'))
