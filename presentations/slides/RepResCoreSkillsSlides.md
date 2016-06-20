R: Core Skills for Reproducible Research
========================================================
author: Maja Založnik
date: 22.3.2016
font-family: 'Helvetica' 'serif'

Outline
========================================================
incremental: true
- Reproducible Research
- RStudio and project management
- Good coding practices in R
- Importing and cleaning data
- Standard control structures
- Vectorisation and `apply` functions
- Writing your own funcitons
- Data manipulation with `dplyr`
- Piping/chaining commands

Slide With Code
========================================================


```r
summary(cars)
```

```
     speed           dist       
 Min.   : 4.0   Min.   :  2.00  
 1st Qu.:12.0   1st Qu.: 26.00  
 Median :15.0   Median : 36.00  
 Mean   :15.4   Mean   : 42.98  
 3rd Qu.:19.0   3rd Qu.: 56.00  
 Max.   :25.0   Max.   :120.00  
```

Slide With Plot
========================================================

RStudio
========================================================
incremental: true
- *Best* IDE for R
- Project management
- Version control
- knitting and direct publishing
- Interactive graphics
- ... 

Project management
========================================================
R project-level files:
- *project* -- .Rproj
- *workspace* -- .RData  
- *history* -- .Rhistory
- *settings* -- .Rprofile

Scripts
- *R code* -- .R

Data
- .csv, .xls, .dat ... 

Figures


Presentation


Good Coding Practice
========================================================
incremental: true
![title](../../figures/code_quality.png)

- [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml)
- [Hadley Wickham's Style Guide](http://adv-r.had.co.nz/Style.html)
- COMMENT EVERYTHING

Literate Programming
========================================================

> “Instead of imagining that our main task is to instruct a computer what to do, let us concentrate rather on explaining to human beings what we want a computer to do.”

> <p style="text-align: right;">Donald Knuth (1984) </p>
