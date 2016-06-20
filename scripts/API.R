require(httr)

api.key <- "192758e78f2d59fc63eabfea55e7cbd25848ed87"


base.url <- "http://api.census.gov/data/timeseries/idb/1year"


# check wchich variables are available on http://api.census.gov/data/timeseries/idb/1year/variables.html

# list variables which you want returned
return.vars <- paste("AGE", "AREA_KM2", "NAME", "POP", "SEX",  "FIPS", sep=",")

# select conditions
year <- 2010
# country <- "NO"


query <- paste(base.url, "?get=", return.vars, 
              "&time=", year,
#                "&FIPS=", country,
               '&key=', api.key,
               sep=""
)


request <- httr::GET(query)
# this is a response object (or a request object?), you can have a look at it's structure
request

# to retrieve the data use the content() function. 
cont <- httr::content(request, as="text")

# to turn it into a data frame, we have to manually turn the first
# row into the column names

df <- data.frame(jsonlite::fromJSON(cont), stringsAsFactors = FALSE)
col.names <- df[1,]

df <- df[-1,]
colnames(df) <- col.names
head(df)
write.csv(df, file="data/pop2010.csv")


