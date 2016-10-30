## on Oxford IT Services network PCs *UNCOMMENT* lines 6 - 13
## otherwise you should be fine with lines 16-19
## and subsequently copy the four library calls  (22-25) into a .RProfile file
## Thanks to Martin Hadley for his help with the code

# # new library path and cran mirror
# pc_name <- tail(unlist(strsplit(path.expand('~'), "/")), n=1)
# new_lib <- paste0("C:\\Users\\",pc_name,"\\R")
# dir.create(new_lib)
# library(utils)
# setInternet2(TRUE)
# options(repos='http://cran.ma.imperial.ac.uk/')
# .libPaths(c(new_lib,.libPaths()))

# need to run only once on each machine
install.packages("dplyr")
install.packages("tidyr")
install.packages("foreign")
install.packages("plotrix")

# need to run every time you start a new R session -> .RProfile!
library(dplyr)
library(tidyr)
library(foreign)
library(plotrix)