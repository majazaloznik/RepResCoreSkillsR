###############################################################################
## DATA IMPORT AND CLEANUP
###############################################################################
## 1.1  Import a .csv file
## 1.2  Download and import an Excel file
## 1.3  Download, unzip and import an SPSS file 
###############################################################################
## 2.1 tidy up the population data
## 2.2 tidy up the perception data
###############################################################################


## 1.1  Import a .csv file
###############################################################################
getwd()

## test run
population2010 <- read.csv("data/pop2010.csv", nrows=10)


## full import
population2010 <- read.csv("data/pop2010.csv", 
                           colClasses = c("integer",   # age
                                          "integer",   # area 
                                          "character", # name 
                                          "integer",   # population
                                          "integer",   # sex
                                          "character", # country id (FIPS)
                                          "NULL"))     # year - skip
head(population2010)
tail(population2010)


## 1.2  Download and import an Excel file
###############################################################################

## url of the .xls file we want (using paste only to keep code under 80 chars:)
data.url <- paste("http://www.ons.gov.uk/ons/rel/social-trends-rd/social-",
            "trends/social-trends-41/income-and-wealth-data.xls", sep="")

## download location 
data.location <-  paste( "data", "income-and-wealth-data.xls", sep = "/")

## download - Excel files are binary, so set the mode to "wb"!!
download.file(data.url, data.location, mode="wb")


## Importing the data from an .xls file
require(xlsx)
## if you get an error telling you there is no package called ‘xlsx’ run:
# install.packages("xlsx")

## let's see what happens if we import the whole sheet
economic.situation <- read.xlsx(data.location, sheetIndex = 3)

## using rowIndex and colIndex select each subtable individually:
world.situation <- read.xlsx(data.location, sheetIndex = 3,
                         rowIndex=c(4, 6:8), colIndex = c(1:7))

UK.situation <- read.xlsx(data.location, sheetIndex = 3,
                             rowIndex=c(4, 11:13), colIndex = c(1:7))

household.situation <- read.xlsx(data.location, sheetIndex = 3,
                          rowIndex=c(4, 16:18), colIndex = c(1:7))


## 1.3  Download, unzip and import a .dat file 
###############################################################################
# url of the .zip file we want
data.zip.url <- paste("http://spss.allenandunwin.com.s3-website-ap-southeast-2.",
                      "amazonaws.com/Files/survey.zip", sep="")
temp <- tempfile()
download.file(data.zip.url, temp)
# check what is in the zip file using list (doens't extract anything)
unzip(temp, list=TRUE)

# Only one file, that's the one we want to extract to the data folder
unzip(temp, "survey.sav", exdir = "data")
unlink(temp)


require(foreign)
## if you get an error telling you there is no package called ‘xlsx’ run:
# install.packages("foreign")

# import the data as a data frame:
data.location <- paste("data","survey.sav", sep="/")
ed.psy.survey <- read.spss(data.location,  to.data.frame=TRUE)
# check what it looks like
ed.psy.survey[1:5,1:5]


# CLEAN UP!
rm(economic.situation, ed.psy.survey, data.location, data.url, data.zip.url, temp)

## 2.1 tidy up the population data
###############################################################################
require(tidyr)
# SEX is the key:
tidy.population2010 <- spread(population2010, SEX, POP)

# for clarity, let's rename the columns:
colnames(tidy.population2010)[5:7] <- c("both", "male", "female")
head(tidy.population2010)

# Now check if the sums are right, by creating a new column:
tidy.population2010$check <- tidy.population2010$male + tidy.population2010$female
all.equal(tidy.population2010$both, tidy.population2010$check)

# looks good, now we can remove both total columns:
tidy.population2010$check <- NULL
tidy.population2010$both <- NULL

# now tidy it up again:
tidy.population2010 <- gather(tidy.population2010, sex, population, 5:6)


## 2.2 tidy up the perception data
###############################################################################

# first let's remane the column names
colnames(household.situation) <- c("perception", "inc.le.20", 
                                   "inc.20.to.39", "inc.40.to.59", 
                                   "inc.60.to.99", "inc.gt.100", "all")
# transpose using gather and spread  
X.household.situation <- gather(household.situation, income.group, proportion, 2:7)
tidy.household.situation <- spread(X.household.situation, perception, proportion)

# add variable for the question asked
tidy.household.situation$perception <- "HH"

# first let's remane the column names
colnames(UK.situation) <- c("perception", "inc.le.20", 
                                   "inc.20.to.39", "inc.40.to.59", 
                                   "inc.60.to.99", "inc.gt.100", "all")
# transpose using gather and spread  
X.UK.situation <- gather(UK.situation, income.group, proportion, 2:7)
tidy.UK.situation <- spread(X.UK.situation, perception, proportion)

# add variable for the question asked
tidy.UK.situation$perception <- "UK"

# first let's remane the column names
colnames(world.situation) <- c("perception", "inc.le.20", 
                            "inc.20.to.39", "inc.40.to.59", 
                            "inc.60.to.99", "inc.gt.100", "all")
# transpose using gather and spread  
X.world.situation <- gather(world.situation, income.group, proportion, 2:7)
tidy.world.situation <- spread(X.world.situation, perception, proportion)

# add variable for the question asked
tidy.world.situation$perception <- "W"

# merge all the tables together
tidy.economic.situation <- rbind(tidy.household.situation,
                                 tidy.UK.situation,
                                 tidy.world.situation) 

# CLEAN UP!
rm(household.situation, 
   tidy.household.situation,
   world.situation,
   tidy.world.situation,
   UK.situation, 
   tidy.UK.situation,
   X.household.situation, 
   X.world.situation, 
   X.UK.situation,
   population2010)

