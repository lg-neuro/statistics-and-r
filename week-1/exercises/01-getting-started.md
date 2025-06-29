---
title: "Getting Started - Week 1"
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

## First assessment

### First assessment Exercise #1

Please note that this question does not count toward your grade, but it is important to make sure that you are using an appropriate version of R.

What version of R are you using?

Correct answer was one of the following: 
```
version 
## R-4.2.0 (released on 2022-04-22, Vigorous Calisthenics)
## R-4.1.3 (released on 2022-03-10, One Push-Up)
## R-4.1.2 (released on 2021-11-01, Bird Hippie)
## R-3.6.3 (released on 2020-02-29, Holding the Windsock)
## R-3.6.2 (released on 2019-12-12, Dark and Stormy Night)
## R-3.6.1 (released on 2019-07-05, Action of the Toes)
## R-3.5.0 (released on 2018-04-23, Joy in Playing)
## R-3.4.4 (2018-03-15, Someone to Lean On) 
## 3.4.3 was released 2017-11-30
## 3.4.2 released 2017-09-2
## 3.4.1 released 2017-06-30
## 3.2.3 (Mac and PC) released 2015-12-10
## 3.2.2 (Mac and PC)
## 3.2.1 (Linux)
```

What I managed to have typing `version` is this:

```{r}
> version                      
platform       x86_64-apple-darwin17.0     
arch           x86_64                      
os             darwin17.0                  
system         x86_64, darwin17.0          
status                                     
major          4                           
minor          2.3                         
year           2023                        
month          03                          
day            15                          
svn rev        83980                       
language       R                           
version.string R version 4.2.3 (2023-03-15)
nickname       Shortstop Beagle 
```

### First assessment Exercises #2

Create a numeric vector containing the numbers 2.23, 3.45, 1.87, 2.11, 7.33, 18.34, 19.23. What is the average of these numbers?

```{r}
x <- c(2.23, 3.45, 1.87, 2.11, 7.33, 18.34, 19.23)
mean(x)
```

### First assessment Exercises #3

Use a for loop to determine the value of $\ \sum_{i=1}^{25} i^2$

```{r}
sum <- 0
for(i in 1:25)
  sum <- sum + i^2
sum
```

### First assessment Exercises #4

The $cars$ dataset is available in base R. You can type $cars$ to see it. Use the class function to determine what type of object is $cars$.

```{r}
class(cars)
```
 

### First assessment Exercises #5

How many rows does the $cars$ object have?

```{r}
nrow(cars)
```
 

### First assessment Exercises #6

What is the name of the second column of $cars$?

```{r}
names(cars)[2]
```

### First assessment Exercises #7

The simplest way to extract the columns of a matrix or data.frame is using `[]`. For example you can access the second column with `cars[,2]`. What is the average distance traveled in this dataset?

```{r}
mean(cars[,2])
```

### First assessment Exercises #8

Familiarize yourself with the which function. What row of cars has a a distance of $85$?

```{r}
which(cars[,2]==85)
```

## Getting Started Exercises

Here we will test some of the basics of R data manipulation which you should know or should have learned by following the tutorials above. You will need to have the file `femaleMiceWeights.csv` in your working directory. As we showed above, one way to do this is by using the downloader package:

```{r}
# install.packages("downloader")
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv"
filename <- "femaleMiceWeights.csv" 
download(url, destfile=filename)
```

### Getting Started Exercises #1

Read in the file `femaleMiceWeights.csv` and report the exact name of the column containing the weights.

```{r}
dat <- read.csv("femaleMiceWeights.csv")
names(dat) 
```

### Getting Started Exercises #2

The [ and ] symbols can be used to extract specific rows and specific columns of the table. What is the entry in the 12th row and second column?

```{r}
dat[12,2]
```

###  Getting Started Exercises #3

You should have learned how to use the $ character to extract a column from a table and return it as a vector. Use $ to extract the weight column and report the weight of the mouse in the 11th row.

```{r}
weights <- dat$Bodyweight
weights[11]

## Or

dat$Bodyweight[11]
```

### Getting Started Exercises #4

The length function returns the number of elements in a vector. How many mice are included in our dataset?

```{r}
weights <- dat$Bodyweight
length(weights)

## I would have used nrow(dat)
```

### Getting Started Exercises #5

To create a vector with the numbers 3 to 7, we can use seq(3,7) or, because they are consecutive, 3:7. View the data and determine what rows are associated with the high fat or hf diet. Then use the mean function to compute the average weight of these mice.

```{r}
View(dat) 
weights <- dat$Bodyweight
mean( weights[ 13:24 ])

## Or

fat_group <- dat$Bodyweight[dat$Diet == "hf"]
mean(fat_group)
```

### Getting Started Exercises #6

One of the functions we will be using often is sample. Read the help file for sample using ?sample. Now take a random sample of size 1 from the numbers 13 to 24 and report back the weight of the mouse represented by that row. Make sure to type set.seed(1) to ensure that everybody gets the same answer.

```{r}
set.seed(1)
i <- sample( 13:24, 1)
dat$Bodyweight[i]
```

## dplyr Exercises

For these exercises, we will use a new dataset related to mammalian sleep. This link describes the data. Download the CSV file from this location:

```{r}
library(downloader)
url="https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- basename(url)
download(url,filename)
```

We are going to read in this data, then test your knowledge of they key `dplyr` functions select and filter. We are also going to review two different _classes_: data frames and vectors.

### dplyr Exercises #1

Read in the `msleep_ggplot2.csv` file with the function `read.csv()` and use the function class to determine what type of object is returned.

```{r}
msleep <- read.csv("msleep_ggplot2.csv")
class(msleep)
```

### dplyr Exercises #2

Now use the `filter()` function to select only the primates. How many animals in the table are primates? Hint: the `nrow()` function gives you the number of rows of a data frame or matrix.

```{r}
install.packages("dplyr")
library(dplyr)

head(msleep)
primates <- filter(msleep, order=="Primates")
nrow(primates)
```

### dplyr Exercises #3

What is the class of the object you obtain after subsetting the table to only include primates?

```{r}
primates <- filter(msleep, order=="Primates")
class(primates)
```

### dplyr Exercises #4

Now use the select function to extract the sleep (total) for the primates. What class is this object? Hint: use `%>%` to pipe the results of the filter function to select.

```{r}
tot_sleep_primates <- primates %>% select(sleep_total)
class(tot_sleep_primates)
```

### dplyr Exercises #5

Now we want to calculate the average amount of sleep for primates (the average of the numbers computed above). One challenge is that the `mean()` function requires a vector so, if we simply apply it to the output above, we get an error. Look at the help file for `unlist()` and use it to compute the desired average.

```{r}
mean_sleep <- filter(msleep, order=="Primates") %>% select(sleep_total) %>% unlist
mean(mean_sleep)
```

### dplyr Exercises #6

For the last exercise, we could also use the `dplyr` `summarize()` function. We have not introduced this function, but you can read the help file and repeat exercise 5, this time using just `filter()` and `summarize()` to get the answer.

```{r}
filter(dat, order=="Primates") %>% summarise(mean(sleep_total))
```