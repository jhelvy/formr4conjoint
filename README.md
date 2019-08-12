# formr4conjoint

[formr](https://formr.org/) is an impressively flexible platform for making surveys using R. In this demo, I'm going to show you one way to use formr to make a choice-based conjoint survey (if you've found this page, I'm going to assume you know what that is).

Here's the [live demo](https://appleconjoint.formr.org/) - a choice-based conjoint survey about apples.

# Getting started

Every formr survey starts with a spreadsheet. I highly recommend using Google sheets for this because 1) formr has a button on the admin page to re-load your Google sheet (otherwise you'd have to upload a .xlsx file), and 2) it's easier to share and manage versions. The [demo sheet](https://docs.google.com/spreadsheets/d/1vXJ8sbkh0p4pM5xNqOelRUmslcq2IHnY9o52RmQLKFw/) they provide covers the full set of supported question types.

For this demo, I'll be using [this Google sheet](https://docs.google.com/spreadsheets/d/1Ih3Pt6uz-gp5vc0SBxBzl4K0aZoRLwI6dtdtZiXSLz0/). 

Don't worry about what's in it just yet - we'll get to that

# Design of experiment 

Every conjoint survey has a deign of experiment. One of the benefits of using formr is that you can use R to fully customize your DOE! In the "survey" folder I have a script called `doe.R` where I define my design of experiment. For this demo, I'm designing a survey to understand people's preferences for apples with just three attributes: type, price, and freshness. (Yes, people have [actually done conjoint surveys on fruit](https://www.emerald.com/insight/content/doi/10.1108/00070709610150879/full/html) before)

For this demo, I'm just using a randomized design from the full factorial (see the `doe.R` file to see exactly what I'm doing). 

# Creating the survey 

Now, open up the survey [Google sheet](https://docs.google.com/spreadsheets/d/1Ih3Pt6uz-gp5vc0SBxBzl4K0aZoRLwI6dtdtZiXSLz0/), which contains the design of the survey questions. 

## Respondent ID

To make a conjoint survey work, you have to keep track of which respondent is taking the survey. To do this in formr requires some tricky steps. Here's how I'm doing it.

At the top of the Google sheet, rows 2-4 do some up-front computations. Respondents don't see these because they are of the type "calculate" (see the "type" column). Here's what they do:

1) Row 2 is called "doePath", and waaaaaay over on the right-most column called "value" I've input the path to the `doe.csv` file in quotes (you can also upload this file to formr inside a survey run, but for now I'm just linking to the file on GitHub). This path gets stored as a character value with the variable name `doePath`.
2) Row 3 is called "maxResp", and you'll see in the "value" column I've written some code to compute the maximum respondent ID number, which gets stored as a variable called `maxResp`. Note that I'm calling the "doePath" variable here to read in the `doe.csv` file. **Important**: Here you just put the direct R code - no need to add the RMarkdown ````{r}` syntax.
3) Finally, I get the current respondentID by using `.formr$nr_of_participants + 1` (`+1` because the first one starts at zero). Note that I have a conditional statement here because if the current respondent number goes beyond the maximum number of respondents in my DOE I'll get an error later. So I use the mod operator (`%%`) to make sure that the respondentID starts over again at 1. 

Note that I also created a row called "imagePath" that stores the path to the images I'll use later.

# Conjoint choice questions 

Now that I've got my `respondentID` variable, I can use it to filter out the full DOE to only show the choice questions for that respondent. In row 10, I have my first conjoint question called "cbc1". In the "type" column I have "mc" (for multiple choice), and then in the "label" column I use a RMarkdown code chunk to filter out the choice alternatives. Note that I also compute the paths to the images associated with each alterantive in this chunk:

````markdown
```{r message=FALSE}
library(data.table)
doe <- fread(doePath)

# Filter for the current respondent
doe <- doe[respID == respondentID]

# Filter out the alternatives for question 1
alt1 <- doe[(altID == 1) & (qID == 1)]
alt2 <- doe[(altID == 2) & (qID == 1)]
alt3 <- doe[(altID == 3) & (qID == 1)]

# Save paths to images
imagePath1 <- paste(imagePath, alt1$image, sep='')
imagePath2 <- paste(imagePath, alt2$image, sep='')
imagePath3 <- paste(imagePath, alt3$image, sep='')
```
(1 of 3) If these were your only options, which would you choose?
````

With each alternative saved as a vector, I then call them in the choice options, also using RMarkdown. Here's what's in the first alternative:

````markdown
**Option 1**

---

![](`r imagePath1`){width=100}

**Type**: `r alt1$type`
**Price**: $ `r alt1$price`
**Freshness**: `r alt1$freshness`
````

And that's it! The only thing I have to do for the other choice questions is update the filtering so that it shows the correct rows for question 2, question 3, etc.

## Uploading the survey

Go to your admin page, click on "Create Survey", then import the Google sheet. On the left panel you can click "Test Survey" to preview it.

## Create a run 

Now that your survey is loaded, click on "Runs -> Create New Run". Give it a name, then click on "Add Survey" to add your "appleConjoint" survey to the run (it's the icon with a pencil in the square).

Then add a stop point (the square icon), and your run is ready to go! To preview it, adjust the "Publicness" setting (the volume icons below the "I am panicking" box).
