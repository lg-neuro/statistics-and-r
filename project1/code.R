library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- basename(url)
download(url, destfile=filename)
dat <- na.omit( read.csv(filename) )

library(rafalib)
library(dplyr)

y <- filter(dat, Sex=="M", Diet=="chow") %>%
     select(Bodyweight) %>%
     unlist()

y_mean <- mean(y)
y_popsd <- popsd(y)

mean((y > (y_mean - y_popsd)) & (y < (y_mean + y_popsd)))


y <- filter(dat, Sex=="M" & Diet=="chow") %>% select(Bodyweight) %>% unlist
z <- ( y - mean(y) ) / popsd(y)

mean( abs(z) <=1 )

mean( abs(z) <=2 )

mean( abs(z) <=3 )
