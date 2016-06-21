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
write.csv(df, file="data/pop2010.csv",row.names = FALSE, quote = 3)


### test
# list variables which you want returned
return.vars <- paste("AGE", "AREA_KM2", "NAME", "POP", "SEX", sep=",")

# select conditions
year <- 2050
country <- "NO"



query <- paste(base.url, "?get=", return.vars, 
               "&time=", year,
                              "&FIPS=", country,
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

SI.2050 <- df#
SI.2010 <- df#
UK.2050 <- df#
UK.2010 <- df#
No.2050 <- df#
No.2010 <- df#
mini2 <- rbind(No.2010, No.2050, SI.2010, SI.2050, UK.2010, UK.2050)
mini2$POP <- as.numeric(mini2$POP)
mini2$AREA_KM2 <- as.numeric(mini2$AREA_KM2)

require(dplyr)
require(tidyr)
mini$POP <- as.numeric(mini$POP)
ex.1 <- mini %>% group_by(FIPS, time, SEX) %>%
  summarise(total.pop = sum(POP)) %>%
  filter(SEX == "0") %>%
  ungroup() %>%
  mutate(FIPS=ifelse(FIPS=="NO", "Norway", ifelse(FIPS == "SI", "Slovenia", "UK"))) %>%
  #unite(Cnty.Sex, FIPS, SEX) %>%
  spread(time, total.pop) %>%
  select(-SEX) 

colnames(ex.1)[1] <- c("country")

ex.1 <- as.data.frame(ex.1)
write.table(ex.1, "data/messy.01.txt")

ex.2 <- mini2 %>% group_by(FIPS, time, SEX) %>%
  summarise(population = sum(POP), density=population/mean(AREA_KM2)) %>%
  filter(SEX == "0") %>%
  ungroup() %>%
  mutate(FIPS=ifelse(FIPS=="NO", "Norway", ifelse(FIPS == "SI", "Slovenia", "UK"))) %>%
  select(-SEX)%>%
  gather(key, value, 3:4)%>%
  arrange(FIPS, time)
colnames(ex.2)[1:2] <- c("country", "year")


ex.2 <- as.data.frame(ex.2)
write.table(ex.2, "data/messy.02.txt")


ex.3 <- mini2 %>% group_by(FIPS, time, SEX) %>%
  summarise(population = sum(POP)) %>%
  filter(SEX != "0") %>%
  ungroup() %>%
  mutate(FIPS=ifelse(FIPS=="NO", "Norway", ifelse(FIPS == "SI", "Slovenia", "UK"))) %>%
  mutate(sex=ifelse(SEX=="1", "male", "female")) %>%
  select(-SEX)%>%
  unite( "double.key", time,sex)
 
ex.3 <- as.data.frame(ex.3)
write.table(ex.3, "data/messy.03.txt")

separate(ex.3, double.key, c("year", "sex"))

