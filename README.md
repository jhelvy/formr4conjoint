
<!-- README.md is generated from README.Rmd. Please edit that file -->

# formr4conjoint

<!-- badges: start -->

[![CC BY-NC-SA
4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by-nc-sa/4.0/)

<!-- badges: end -->

[formr.org](https://formr.org/) is a flexible platform for making
surveys using
<img src="figs/fa-icon-3b6b9d998f60a2b82069ad0e55a411dd.svg" style="width:1.13em;height:1em" />.
This repo contains files for designing and implementing a demo conjoint
survey with formr about people’s preferences for apples with three
attributes: `type`, `price`, and `freshness`.

See [this
post](https://www.jhelvy.com/posts/2021-09-18-choice-based-conjoint-surveys-in-r-with-formr/)
for more details about the demo.

You can view the live demo survey
[here](https://appleconjoint.formr.org/)

## Packages

If you want to run the code in the `survey` folder, you will need to
install the following packages:

``` r
install.packages(c("remotes", "tidyverse", "jsonlite"))
remotes::install_github("jhelvy/conjointTools")
```

## Author and License Information

-   Author: *John Paul Helveston* <https://www.jhelvy.com/>
-   Date First Written: *Monday, August 12, 2019*
-   This work is licensed under a [Creative Commons
    Attribution-NonCommercial-ShareAlike 4.0 International
    License](http://creativecommons.org/licenses/by-nc-sa/4.0/).

[![CC BY-NC-SA
4.0](https://licensebuttons.net/l/by-nc-sa/4.0/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/4.0/)
