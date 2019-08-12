library(here)

# Get the full factorial design  
ff <- expand.grid(
    type      = c('Fuji', 'Gala', 'Honeycrisp', 'Pink Lady', 'Red Delicious'),
    price     = seq(1, 4, 0.5), # $ per pound 
    freshness = c('Excellent', 'Average', 'Poor')
)

# Add image names to match the apple type
ff <- merge(ff, data.frame(
    type  = c('Fuji', 'Gala', 'Honeycrisp', 'Pink Lady', 'Red Delicious'),
    image = c('fuji.jpg', 'gala.jpg', 'honeycrisp.jpg', 'pinkLady.jpg', 
              'redDelicious.jpg')))

# Sample from full factorial to populate doe
N    <- 4500 
rows <- sample(x=seq(nrow(ff)), size=N, replace=T)
doe  <- ff[rows,]

# Add meta data
nAltsPerQ <- 3 # Number of alternatives per question
nQPerResp <- 3 # Number of questions per respondent
nRowsPerResp   <- nAltsPerQ * nQPerResp 
nResp          <- nrow(doe) / nRowsPerResp # Expecting 500 respondents
doe$respID     <- rep(seq(nResp), each=nRowsPerResp)
doe$qID        <- rep(rep(seq(nQPerResp), each=nAltsPerQ), nResp)
doe$altID      <- rep(seq(nAltsPerQ), nResp*nQPerResp)
doe$obsID      <- rep(seq(nResp * nQPerResp), each=nAltsPerQ)
row.names(doe) <- seq(nrow(doe))

# Save design
write.csv(doe, here::here('survey', 'doe.csv'), row.names=F)
