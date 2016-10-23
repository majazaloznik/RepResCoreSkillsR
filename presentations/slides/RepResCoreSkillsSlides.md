R: Core Skills for Reproducible Research
========================================================
width:1200

Maja Zalo&#x17e;nik

31.10.2016



Outline
========================================================
incremental: true
- Reproducible Research
- RStudio and project management
- Good coding practices in R
- Importing and cleaning data
- Standard control structures
- Vectorisation and `apply` functions
- Writing your own functions
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

* Data formats and sources 
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

For a quick tidyr cheat-sheet stick this to your wall: [Data Wrangling Cheatsheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf), also available in the `literature` folder of this course's repository. 


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
* Vectorisation and `apply` family of functions
* Writing your own functions
* Data manipulation with `dplyr`
  + Sub-setting
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
 [1] "G" "N" "G" "N" "G" "B" "G" "B" "G" "N" "G" "G" "N" "G" "B" "B" "B"
[18] "B" "B" "B"
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
[1,]   14   85   68    2    1
[2,]   43   20   15   73   36
[3,]   42   23   75   40   32
[4,]   10   61   95   62   19
[5,]   50   34   31   29   12
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
[1] 68 43 42 62 34
```

```r
# using apply()
apply(mat, 1, function(x) sort(x, decreasing = TRUE)[2])
```

```
[1] 68 43 42 62 34
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
[1] 68 43 42 62 34
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

* Sub-setting:
  + `filter()`
  + `select()`
* Calculating:
  + `mutate()`
  + `summarise()`
* Helpers:
  + `group_by()` and `ungroup()`
  + `arrange()`

Filtering - rows
========================================================
incremental:true


```r
filter(data, criteria)
```



```r
filter(tidy.population2010, 
       AREA_KM2 < 1000 & population > 10000 & AGE == 0)
```

```
  AGE AREA_KM2       NAME FIPS    sex population
1   0      360 Gaza Strip   GZ   male      29209
2   0      687  Singapore   SN   male      18632
3   0      360 Gaza Strip   GZ female      27616
4   0      687  Singapore   SN female      17438
```

Selecting - columns
========================================================
incremental:true


```r
select(data, list)
```



```r
select(tidy.economic.situation, bad, good, neutral)
```

```
   bad good neutral
1   25   28      47
2   14   44      42
3   11   54      35
4    1   64      36
5    3   63      34
6   18   40      43
7   76    8      17
8   80    5      15
9   83    4      13
10  92    4       4
11  89    0      11
12  80    6      15
13  77    6      17
14  79    3      18
15  85    2      12
16  91    1       8
17  92    0       8
18  80    4      16
```

Selecting - columns
========================================================
incremental:true

```r
# all the columns between bad and neutral
select(tidy.economic.situation, bad:neutral)
# all but the perception column
select(tidy.economic.situation, -perception)
# contains a dot in the name:
select(tidy.economic.situation, contains("."))
# starts with the letter p
select(tidy.economic.situation, starts_with("p"))
# ends with the letter d
select(tidy.economic.situation, ends_with("d"))
# contains the text "n"
select(tidy.economic.situation, contains("n"))
```


```r
# change order of columns by name
select(tidy.economic.situation,income.group:bad, neutral, good:perception), n=3
# we can also do this using the columns' respective indices instead
select(tidy.economic.situation, 1,2,4,3,5), n=3
```

Calculating - new variables (columns)
========================================================
incremental:true

```r
# scale the values so they all sum up to 100
mutate(tidy.economic.situation, 
       total = bad+neutral+good, 
       bad.s = bad/total*100,
       good.s = good/total*100,
       neutral.s = neutral/total*100,
       total.s =  bad.s  + good.s + 
         neutral.s
)
```


```
   income.group perception   bad.s good.s neutral.s
1     inc.lt.20         HH 25.0000 28.000     47.00
2  inc.20.to.39         HH 14.0000 44.000     42.00
3  inc.40.to.59         HH 11.0000 54.000     35.00
4  inc.60.to.99         HH  0.9901 63.366     35.64
5    inc.gt.100         HH  3.0000 63.000     34.00
6           all         HH 17.8218 39.604     42.57
7     inc.lt.20         UK 75.2475  7.921     16.83
8  inc.20.to.39         UK 80.0000  5.000     15.00
9  inc.40.to.59         UK 83.0000  4.000     13.00
10 inc.60.to.99         UK 92.0000  4.000      4.00
11   inc.gt.100         UK 89.0000  0.000     11.00
12          all         UK 79.2079  5.941     14.85
13    inc.lt.20          W 77.0000  6.000     17.00
14 inc.20.to.39          W 79.0000  3.000     18.00
15 inc.40.to.59          W 85.8586  2.020     12.12
16 inc.60.to.99          W 91.0000  1.000      8.00
17   inc.gt.100          W 92.0000  0.000      8.00
18          all          W 80.0000  4.000     16.00
```

Calculating - new observations (rows)
========================================================
incremental:true


```r
summarise(data, new.var = summary.function(column))
```


```r
summarise(tidy.population2010, 
          av.pop = mean(population), 
          av.area = mean(AREA_KM2), 
          count = n(), 
          second = FunSecondLargest(population))
```

```
  av.pop av.area count   second
1 149087  578149 46056 14642884
```

Calculating - new observations (rows) - grouped
========================================================
incremental:true

```r
gr <- group_by(tidy.population2010, AGE)
summarise(gr, pop = mean(population), 
          area = mean(AREA_KM2), 
          count = n(), 
          second = FunSecondLargest(population))
```

```
Source: local data frame [101 x 5]

     AGE    pop   area count   second
   (int)  (dbl)  (dbl) (int)    (int)
1      0 282738 578149   456 11355900
2      1 278558 578149   456 11177984
3      2 275981 578149   456 11082923
4      3 272960 578149   456 11021599
5      4 270025 578149   456 11002862
6      5 267803 578149   456 11022271
7      6 266032 578149   456 11037275
8      7 264164 578149   456 11040174
9      8 262954 578149   456 11030910
10     9 262510 578149   456 11016559
..   ...    ...    ...   ...      ...
```

Sorting data
========================================================
incremental:true


```r
# `arrange()` for data sorting on columns
arrange(tidy.economic.situation, perception, desc(bad.s))
```

```
   income.group perception   bad.s good.s neutral.s
1     inc.lt.20         HH 25.0000 28.000     47.00
2           all         HH 17.8218 39.604     42.57
3  inc.20.to.39         HH 14.0000 44.000     42.00
4  inc.40.to.59         HH 11.0000 54.000     35.00
5    inc.gt.100         HH  3.0000 63.000     34.00
6  inc.60.to.99         HH  0.9901 63.366     35.64
7  inc.60.to.99         UK 92.0000  4.000      4.00
8    inc.gt.100         UK 89.0000  0.000     11.00
9  inc.40.to.59         UK 83.0000  4.000     13.00
10 inc.20.to.39         UK 80.0000  5.000     15.00
11          all         UK 79.2079  5.941     14.85
12    inc.lt.20         UK 75.2475  7.921     16.83
13   inc.gt.100          W 92.0000  0.000      8.00
14 inc.60.to.99          W 91.0000  1.000      8.00
15 inc.40.to.59          W 85.8586  2.020     12.12
16          all          W 80.0000  4.000     16.00
17 inc.20.to.39          W 79.0000  3.000     18.00
18    inc.lt.20          W 77.0000  6.000     17.00
```

Joining tables
========================================================

- `left_join(a, b)` -- keeps all rows in first table
- `right_join(a, b)` -- keeps all rows in second table
- `inner_join(a, b)` -- only keeps rows present in both a and b
- `full_join(a, b)` -- keeps all rows



Piping
========================================================

<div align="center">
<img src="../../figures/pipe.jpg" height=500>
</div> <p style="text-align: right;"><small>[Photo by Joe Cross](https://www.flickr.com/photos/jaycross/2869212451)</small> </p>

Without Piping
========================================================
incremental:true


```r
data.subset <-  filter(tidy.population2010, AREA_KM2 < 2000 & population > 15000 & AGE == 0)
```

```r
data.subset2 <- select(data.subset, -AGE) 
```

```r
data.subset3 <-  mutate(data.subset2, density = population/AREA_KM2) 
```

```r
data.grouped <-   group_by(data.subset3, NAME)
```

```r
summarise(data.grouped, count = n(), mean.density = mean(density)) 
```

```
Source: local data frame [3 x 3]

        NAME count mean.density
      (fctr) (int)        (dbl)
1 Gaza Strip     2        78.92
2  Hong Kong     2        28.07
3  Singapore     2        26.25
```

With Piping
========================================================
incremental:true

```r
tidy.population2010 %>%
  filter(AREA_KM2 < 2000 & population > 15000 & AGE == 0) %>%
  select(-AGE) %>%
  mutate(density = population/AREA_KM2) %>%
  group_by(NAME) %>%
  summarise(count = n(), mean.density = mean(density)) -> final.table
```

```r
final.table
```

```
Source: local data frame [3 x 3]

        NAME count mean.density
      (fctr) (int)        (dbl)
1 Gaza Strip     2        78.92
2  Hong Kong     2        28.07
3  Singapore     2        26.25
```


PRACTICAL III
========================================================


```r
##########################################################
## PIPING and POPULATION PYRAMIDS
##########################################################
## 4.0 Practice piping on population2010
## 4.1 Write a function to extract population pyramid data
## 4.2 Write a function to plot the output of 4.1
##########################################################
```

PRACTICAL III.i
========================================================

```r
##########################################################
## 4.0 Practice piping on population2010
##########################################################
```
Using the `population2010.csv` file find the answers to the following:

* How many 20 year-old males were there in Tanzania in 2010
* Which country has the lowest total population?
* In which country do women outnuber men in the most age groups?

PRACTICAL III.I solutions
========================================================
incremental:true


```r
# How many 20 year-old males were there in Tanzania in 2010
tidy.population2010 %>%
  filter(FIPS == "TZ" & AGE == 20 & sex == "male")
```

```
  AGE AREA_KM2     NAME FIPS  sex population
1  20   885800 Tanzania   TZ male     424839
```

PRACTICAL III.I solutions
========================================================
incremental:true


```r
# Which country has the lowest total population?
tidy.population2010 %>%
  group_by(NAME) %>%
  summarise( population = sum(population)) %>%
  arrange(population)
```

```
Source: local data frame [228 x 2]

                        NAME population
                      (fctr)      (int)
1                 Montserrat       5118
2  Saint Pierre and Miquelon       5943
3           Saint Barthelemy       7406
4               Saint Helena       7670
5                      Nauru       9267
6                     Tuvalu      10472
7               Cook Islands      11488
8                   Anguilla      14766
9          Wallis and Futuna      15343
10                     Palau      20879
..                       ...        ...
```

PRACTICAL III.I solutions
========================================================
incremental:true


```r
# In which country do women outnuber men in the most age groups?
tidy.population2010 %>%
  spread(sex, population) %>%
  mutate(morewomen = ifelse(female > male, 1, 0)) %>%
  filter(morewomen == 1) %>%
  group_by(NAME) %>%
  summarise(most.ages = sum(morewomen)) %>%
  arrange(desc(most.ages))
```

```
Source: local data frame [228 x 2]

                   NAME most.ages
                 (fctr)     (dbl)
1          Sierra Leone        98
2              Cambodia        92
3               Comoros        92
4                Malawi        91
5           Gambia, The        90
6            Mauritania        90
7  Virgin Islands, U.S.        90
8            Mozambique        88
9                Uganda        88
10             Djibouti        87
..                  ...       ...
```
