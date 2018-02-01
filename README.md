
<!-- README.md is generated from README.Rmd. Please edit that file -->
datademon
=========

This is a package that has some common functions and styles that are useful for Wake Forest University. This includes:

Stylistic Points
----------------

-   Color Pallettes
-   Font Selections
-   Chart Formatting

USeful Functions
----------------

These have been gathered over my experience and can be useful \* Exploratory Data Analysis Tools \* Common Functions I use \* Data cleaning Tools

Installation
------------

You can install datademon from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("medewitt/datademon")
```

Guide
-----

### Application of the Wake Style Guide

``` r
library(datademon)
library(ggplot2)
library(extrafont)
#> Registering fonts with R

ggplot(diamonds, aes(carat, price, group = color, color = color))+
  geom_point()+
  scale_colour_wake()+
  theme_wake()
```

<img src="man/figures/README-unnamed-chunk-1-1.png" width="100%" />

### Application of the Wellbeing Survey Template

``` r
ggplot(diamonds, aes(carat, price, group = color, color = color))+
  geom_point()+
  scale_colour_wellness()+
  theme_wellbeing()
```

<img src="man/figures/README-unnamed-chunk-2-1.png" width="100%" />

### Application of Likert Six Scale

### Application of

Thanks
------

Not all of these tools originated from me. Many have been stolen with pride and modified. Special thanks to Bob Rudis for his work with the hrbrthemes package which helped me create all of my themes. Additional thanks to Karl Broman for some of his tools. And of course to RStudio for making the tools easier and easier to use.
