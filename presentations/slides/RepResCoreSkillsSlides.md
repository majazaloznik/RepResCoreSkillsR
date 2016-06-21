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



Practical I. - project setup
========================================================

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
