# formr4conjoint

[formr](https://formr.org/) is an impressively flexible platform for making surveys using R. In this demo, I'm going to show you one way to use formr to make a choice-based conjoint survey. If you've found this page, I'm going to assume you know what that is.

# Getting started

Every formr survey starts with a spreadsheet. I highly recommend using Google sheets for this because 1) formr has a button on the admin page to re-load your Google sheet (otherwise you'd have to upload a .xlsx file), and 2) it's easier to share and manage versions. The [demo sheet](https://docs.google.com/spreadsheets/d/1vXJ8sbkh0p4pM5xNqOelRUmslcq2IHnY9o52RmQLKFw/) they provide covers the full set of supported question types.

For this demo, I'll be using [this Google sheet](https://docs.google.com/spreadsheets/d/1Ih3Pt6uz-gp5vc0SBxBzl4K0aZoRLwI6dtdtZiXSLz0/). 

Don't worry about what's in it just yet - we'll get to that

# Design of experiment 

Every conjoint survey has a deign of experiment. One of the benefits of using formr is that you can use R to fully customize your DOE! In the "survey" folder I have a script called `doe.R` where I define my design of experiment. For this demo, I'm designing a survey to understand people's preferences for apples with just three attributes: type, price, and freshness. (Yes, people have [actually done conjoint surveys on fruit](https://www.emerald.com/insight/content/doi/10.1108/00070709610150879/full/html) before)

For this demo, I'm just using a randomized design from the full factorial (see the `doe.R` file to see exactly what I'm doing). 

# Survey sheet 

Now, open up the survey [Google sheet](https://docs.google.com/spreadsheets/d/1Ih3Pt6uz-gp5vc0SBxBzl4K0aZoRLwI6dtdtZiXSLz0/), which contains the design of the survey questions. To make a conjoint survey work, you have to keep track of which respondent is taking the survey. To do this in formr, I include a few rows at the top of the survey. 

# Create the survey 

Go to your admin page, click on "Create Survey", then import the Google sheet. 
