R: Core Skills for Reproducible Research
========================================================
width:1200

Maja Zalo&#x17e;nik

22.3.2016



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

Rules
========================================================
- Don't forget to mention the rules! 

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
incremental: true

R project-level files:
- *project* -- .Rproj
- *workspace* -- .RData  
- *history* -- .Rhistory
- *settings* -- .Rprofile

Scripts -- .R

Data -- .csv, .xls, .dat ... 

Figures

Presentation -- .pdf, .doc, .html, (.tex)

Good Coding Practice
========================================================
incremental: true
![title](../../figures/code_quality.png)

- [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml)
- [Hadley Wickham's Style Guide](http://adv-r.had.co.nz/Style.html)
- COMMENT EVERYTHING

Literate Programming
========================================================

> "Instead of imagining that our main task is to instruct a computer what to do, let us concentrate rather on explaining to human beings what we want a computer to do."

> <p style="text-align: right;">Donald Knuth (1984) </p>




Janitor work
========================================================
incremental: true
> Data scientists, according to interviews and expert estimates, spend from 50 percent to 80 percent of their time mired in this more mundane labor of collecting and preparing unruly digital data, before it can be explored for useful nuggets. <p style="text-align: right;"><a href="http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html?_r=0">source: NY Times</a></p>

* Data formats, sources, and 
* `tidyr` package
  + `spread()` and  `gather()`
  + `separate()` and  `unite()`
  
Tidy Data
========================================================
incremental:true
> *Tidy datasets are all alike but every messy dataset is messy in its own way.* - Hadley Wickham

1. Each variable forms a column.
2. Each observation forms a row.
3. Each type of observational unit forms a table.


Tidy Data - spread()
========================================================

```
    country year        key       value
1    Norway 2010 population  4891300.00
2    Norway 2010    density       16.07
3    Norway 2050 population  6364008.00
4    Norway 2050    density       20.91
5  Slovenia 2010 population  2003136.00
6  Slovenia 2010    density       99.41
7  Slovenia 2050 population  1596947.00
8  Slovenia 2050    density       79.25
9        UK 2010 population 62348447.00
10       UK 2010    density      257.71
11       UK 2050 population 71153797.00
12       UK 2050    density      294.11
```

Tidy Data - spread()
========================================================

```r
tidy.02 <- spread(messy.02, key, value)
tidy.02
```

```
   country year density population
1   Norway 2010   16.07    4891300
2   Norway 2050   20.91    6364008
3 Slovenia 2010   99.41    2003136
4 Slovenia 2050   79.25    1596947
5       UK 2010  257.71   62348447
6       UK 2050  294.11   71153797
```


Tidy Data -- key : value pairs
========================================================


```r
Country: Norway
Country: Slovenia 
...
Year: 2010
Year: 2050

Population: 4891300
Population: 2003136
...
Density: 16.07489
Density: 20.91484
...
```

Tidy data: 
* each column name is a *key*
* each cell is a *value*

Tidy Data - gather()
========================================================
incremental:true

```
   country    X2010    X2050
1   Norway  4891300  6364008
2 Slovenia  2003136  1596947
3       UK 62348447 71153797
```


```r
tidy.01 <- gather(messy.01, year, population, 2:3)
tidy.01
```

```
   country year population
1   Norway 2010    4891300
2 Slovenia 2010    2003136
3       UK 2010   62348447
4   Norway 2050    6364008
5 Slovenia 2050    1596947
6       UK 2050   71153797
```

Tidy Data - separate() 
========================================================

```
    country      double.key       value
1    Norway 2010_population  4891300.00
2    Norway    2010_density       16.07
3    Norway 2050_population  6364008.00
4    Norway    2050_density       20.91
5  Slovenia 2010_population  2003136.00
6  Slovenia    2010_density       99.41
7  Slovenia 2050_population  1596947.00
8  Slovenia    2050_density       79.25
9        UK 2010_population 62348447.00
10       UK    2010_density      257.71
11       UK 2050_population 71153797.00
12       UK    2050_density      294.11
```
Tidy Data - separate() 
========================================================

```r
tidy.03 <- separate(messy.03, double.key, c("year", "key"))
tidy.03
```

```
    country year        key       value
1    Norway 2010 population  4891300.00
2    Norway 2010    density       16.07
3    Norway 2050 population  6364008.00
4    Norway 2050    density       20.91
5  Slovenia 2010 population  2003136.00
6  Slovenia 2010    density       99.41
7  Slovenia 2050 population  1596947.00
8  Slovenia 2050    density       79.25
9        UK 2010 population 62348447.00
10       UK 2010    density      257.71
11       UK 2050 population 71153797.00
12       UK 2050    density      294.11
```

Tidy Data - unite() 
========================================================

```r
messy.again <- unite(tidy.03, new.double.key, key, year,  
                     sep = " in the year ")
messy.again
```

```
    country              new.double.key       value
1    Norway population in the year 2010  4891300.00
2    Norway    density in the year 2010       16.07
3    Norway population in the year 2050  6364008.00
4    Norway    density in the year 2050       20.91
5  Slovenia population in the year 2010  2003136.00
6  Slovenia    density in the year 2010       99.41
7  Slovenia population in the year 2050  1596947.00
8  Slovenia    density in the year 2050       79.25
9        UK population in the year 2010 62348447.00
10       UK    density in the year 2010      257.71
11       UK population in the year 2050 71153797.00
12       UK    density in the year 2050      294.11
```

Tidy Data - Resources
========================================================
For an excellent write-up of the main `tidyr` functions see Garrett Grolemund's post here [http://garrettgman.github.io/tidying/](http://garrettgman.github.io/tidying/).

For a quick tidyr cheat-sheet stick this to your wall: [Data Wrangling Cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf), also available in teh `literature` folder of this course's repository. 


Practical I. - project setup
========================================================
The complete documentation for this course is available as an RStudio project in a public github repository:
[https://github.com/majazaloznik/RepResCoreSkillsR](https://github.com/majazaloznik/RepResCoreSkillsR) 
or for extra convenience: [http://tinyurl.com/RCSRepRes](http://tinyurl.com/RCSRepRes)

* navigate to the repo and open the RepResCoreSkillsManual.pdf in the /presentations/manual folder. 

* find the instructions for Practicals I and II in the manual


Practical II. - import and clean data
========================================================

```r
##########################################################
## DATA IMPORT AND CLEANUP
##########################################################
## 1.1  Import a .csv file
## 1.2  Download and import an Excel file
## 1.3  Download, unzip and import an SPSS file 
##########################################################
## 2.1  Data tidying
##########################################################
```

Efficient Coding Practices
========================================================
incremental:true

* Standard control structures
  + Conditional execution
  + Looping
* Vectorisation and `apply` family of funcitons
* Writing your own functions
* Data manipulation with `dplyr`
  + Subsetting
  + Grouping
  + Making new variables
  + Piping/chaining daisies 

Conditional execution
========================================================
incremental:true

```r
if (condition) {
  # do something
} else {
  # do something else
}
```


```r
x <- runif(1) # randum number from uniform distribution [0,1]
if (x >= 0.6) {
  print("Good")
} else {
  if (x <= 0.4) {
    print("Bad")
  } else {
    print("Not Sure")}
}
```

```
[1] "Good"
```

Conditional execution - conditions and operators
========================================================
incremental:true

```r
x == y   # x is equal to y
x != y   # x is not equal to y
x > y    # x is greater than y
x < y    # x is less than y
x <= y   # x is less than or equal to y
x >= y   # x is greater than or equal to y
x %in% y  # x is located in y
TRUE     # 
FALSE    #
```


```r
!x        # NOT
x & y     # AND
x | y     # OR
xor(x, y)  # exclusive OR
```

Conditional execution - vectorised
========================================================
incremental:true

```r
ifelse(condition, yes, no)
```


```r
x <- runif(20) # 20 randum numbers from uniform distribution [0,1]
ifelse(x >= 0.6, "G", 
       ifelse(x<=0.4, "B", "N"))
```

```
 [1] "B" "B" "G" "B" "G" "N" "G" "B" "G" "N" "G" "B" "N" "B" "B" "G" "B"
[18] "B" "N" "G"
```



Looping - for() loop
========================================================
incremental:true

```r
for (i in seq) expr
```


```r
mat <- matrix(NA, nrow=3, ncol=3)
for (i in 1:3){
  for (j in 1:3){
    mat[i,j] <- paste(i, j, sep="-")
  }
} 
mat
```

```
     [,1]  [,2]  [,3] 
[1,] "1-1" "1-2" "1-3"
[2,] "2-1" "2-2" "2-3"
[3,] "3-1" "3-2" "3-3"
```



Vectorisation - apply()
========================================================
incremental:true

```r
apply(X, MARGIN, FUN, ...)
```


```r
mat <- matrix(1:9, 3,3)
# row totals
apply(mat, 1, sum)
```

```
[1] 12 15 18
```

```r
# column totals
apply(mat, 2, sum)
```

```
[1]  6 15 24
```

Vectorisation - apply() vs for()
========================================================
incremental:true

```r
mat <- matrix(sample(1:100, 25), 5,5)
mat
```

```
     [,1] [,2] [,3] [,4] [,5]
[1,]   76   14   15    7   29
[2,]   43   69   48   40   93
[3,]   26   64   98   34   83
[4,]    8   38   66   72   16
[5,]   78   46   92   74   89
```

```r
# find the second largest value in each row
out <- vector()
for (i in 1:nrow(mat)) {
  out[i] <- sort(mat[i,], decreasing = TRUE)[2]
}
```
Vectorisation - apply() vs for()
========================================================
incremental:true

```r
for (i in 1:nrow(mat)) {
  out[i] <- sort(mat[i,], decreasing = TRUE)[2]
}
out
```

```
[1] 29 69 83 66 89
```

```r
# using apply()
apply(mat, 1, function(x) sort(x, decreasing = TRUE)[2])
```

```
[1] 29 69 83 66 89
```
Vectorisation - lapply() and sapply()
========================================================
incremental:true

```r
# a list of elements with different lengths:
test <- list(a = 1:5, b = 20:100, c = 17234) 
lapply(test, min)
```

```
$a
[1] 1

$b
[1] 20

$c
[1] 17234
```

```r
sapply(test, min)
```

```
    a     b     c 
    1    20 17234 
```
Vectorisation - lapply() and sapply()
========================================================
incremental:true

```r
# a data frame (list of three vectors of equal length):
test <- data.frame(a = 1:5, b = 6:10, c = 11:15) 
lapply(test, mean)
```

```
$a
[1] 3

$b
[1] 8

$c
[1] 13
```

```r
sapply(test, mean)
```

```
 a  b  c 
 3  8 13 
```
Writing your own functions
========================================================
incremental:true


```r
function.name <- function(arguments, ...) {
  expression
  (return value)
}
```


```r
function(x) sort(x, decreasing = TRUE)[2]
```

Writing your own functions
========================================================
incremental:true


```r
FunSecondLargest <-function(x) {
  r <- sort(x, decreasing = TRUE)[2]
  return(r)
}
```

```r
# now let's try it out with a sample vector
test.vector <- tidy.population2010$population

FunSecondLargest(test.vector)  
```

```
[1] 14642884
```

```r
apply(mat, 1, FunSecondLargest)
```

```
[1] 29 69 83 66 89
```

Writing your own functions
========================================================
incremental:true


```r
# Function for extracting the n-th largest value from a vector
# Agruments: x - vector,  n - optional integer value for rank
# Output:returns single value 
FunNthLargest <-function(x, n=1) {
  r <- sort(x, decreasing = TRUE)[n]
  return(r)
}
```

```r
FunNthLargest(test.vector)  
```

```
[1] 15120232
```

```r
FunNthLargest(test.vector, n=2)  
```

```
[1] 14642884
```

```r
FunNthLargest(test.vector, n=3)  
```

```
[1] 13601669
```

Practical II
========================================================

```r
###########################################################
## CONDITIONAL EXPR, LOOPS, APPLY AND FUNCTIONS
###########################################################
## 3.1 Conditional expressions and logical operators 
## 3.2 For() loops
## 3.3 Funciton writing
## 3.4 Use your function inside an apply statement
## 3.5 Bar-Plotting function
###########################################################
```

Data manipulation with `dplyr`
========================================================
incremental:true

Piping
========================================================

<div align="center">
<img src="../../figures/pipe.jpg" height=500>
</div>> <p style="text-align: right;"><small>[Photo by Joe Cross](https://www.flickr.com/photos/jaycross/2869212451)</small> </p>

