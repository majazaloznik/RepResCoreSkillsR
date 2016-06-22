###############################################################################
## PIPING and POPULATION PYRAMIDS
###############################################################################
## 4.1 Write a function to extract population pyramid data
## 4.2 Write a function to plot the output of 4.1
###############################################################################


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
    filter( sex=="male") %>%
    select(prop) %>% 
    as.matrix -> lx
  data %>%  
    filter( sex=="male") %>%
    select(prop) %>% 
    as.matrix -> rx
  pyramid.plot(lx, rx,
               main=name,
               labels = paste(seq(0,96, 5), seq(5,100,5), sep="-"))
}

