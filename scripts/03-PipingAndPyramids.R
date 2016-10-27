##########################################################
## PIPING and POPULATION PYRAMIDS
##########################################################
## 4.0 Practice piping on population2010
## 4.1 Write a function to extract population pyramid data
## 4.2 Write a function to plot the output of 4.1
##########################################################
# in case you skipped on the first and second practical, uncomment the following line and 
# run it to get all the data you need:
load("data/tidy.data.RData")
## 4.0 Practice piping on population2010
##########################################################
# How many 20 year-old males were there in Tanzania in 2010
tidy.population2010 %>%
  filter(FIPS == "TZ" & AGE == 20 & sex == "male")

# Which country has the lowest total population?
tidy.population2010 %>%
  group_by(NAME) %>%
  summarise(population = sum(population)) %>%
  arrange(population)

# In which country do women outnuber men in the most age groups?
tidy.population2010 %>%
  spread(sex, population) %>%
  mutate(morewomen = ifelse(female > male, 1, 0)) %>%
  filter(morewomen == 1) %>%
  group_by(NAME) %>%
  summarise(most.ages = sum(morewomen)) %>%
  arrange(desc(most.ages))

  
## 4.1 Write a function to extract population pyramid data
###############################################################################
FunPopClean <- function(cntry = "UK"){
  tidy.population2010 %>%
    filter(FIPS == cntry) %>%
    mutate(age.g = cut(AGE, 20)) %>%
    group_by(age.g, sex) %>%
    summarise(population = sum(population)) %>%
    ungroup() %>%
    mutate(prop = 100*population/sum(population)) ->
    data
  return(data)
}


## 4.2 Write a function to draw a population pyramid plot
###############################################################################
FunPlot <- function(data, name = NULL){
  data %>%  
    dplyr::filter( sex=="male") %>%
    select(prop) %>% 
    as.matrix -> lx
  data %>%  
    dplyr::filter( sex=="male") %>%
    select(prop) %>% 
    as.matrix -> rx
  pyramid.plot(lx, rx,
               main=name,
               labels = paste(seq(0,96, 5), seq(5,100,5), sep="-"))
}


FunPlot(FunPopClean("AA"), name = "Populaiton Pyramid of Aruba")
