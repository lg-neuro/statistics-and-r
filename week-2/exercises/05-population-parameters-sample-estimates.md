---
title: "Cetral Limit Theorem - Week 2"
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

### Population, Samples, and Estimates Exercises

For these exercises, we will be using the following dataset:

```R
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- basename(url)
download(url, destfile=filename)
dat <- read.csv(filename) 
```

We will remove the lines that contain missing values:

```R
dat <- na.omit( dat )
```

### Population, Samples, and Estimates Exercises #1

Use `**dplyr**` to create a vector $x$ with the body weight of all males on the control (`chow`) diet. **Answer: $30.96381$**

```R
x <- filter(dat, Diet=="chow", Sex=="M") %>% 
     select(Bodyweight) %>%
     unlist()
mean(x)
```

### Population, Samples, and Estimates Exercises #2

Now use the `**rafalib**` package and use the `popsd()` function to compute the population standard deviation. **Answer: $4.420501$**

```R
library(rafalib)
popsd(x)
```

### Population, Samples, and Estimates Exercises #3

Set the seed at $1$. Take a random sample $X$ of size $25$ from $x$. What is the sample average? **Answer: $30.5196$**

```R
set.seed(1)
X <- sample(x, 25)
mean(X)
```

### Population, Samples, and Estimates Exercises #4

Use `**dplyr**` to create a vector $y$ with the body weight of all males on the high fat (`hf`) diet. What is this population's average? **Answer: $34.84793$**

```R
library(dplyr)
y <- filter(dat, Sex=="M", Diet=="hf") %>%
     select(Bodyweight) %>%
     unlist()
mean(y)
```

### Population, Samples, and Estimates Exercises #5

Now use the `**rafalib**` package and use the `popsd()` function to compute the population standard deviation. **Answer: $5.574609$**

```R
library(rafalib)
popsd(y)
```

### Population, Samples, and Estimates Exercises #6

Set the seed at $1$. Take a random sample $Y$ of size $25$ from $y$. What is the sample average? **Answer: $35.8036$**

```R
set.seed(1)
Y <- sample(x, 25)
mean(Y)
```

### Population, Samples, and Estimates Exercises #7

What is the difference in absolute value between $\bar{y} - \bar{x}$ and $\bar{Y} - \bar{X}$? **Answer: $1.399884$** 

```R
abs( (mean(y) - mean(x)) - (mean(Y) - mean(X)) )
```

### Population, Samples, and Estimates Exercises #8

Repeat the above for females, this time setting the seed to $2$. (Make sure to set the seed to 2 before each `sample()` call. This function should be called twice.) What is the difference in absolute value between $\bar{y} - \bar{x}$ and $\bar{Y} - \bar{X}$? **Answer: $0.3647172 or 4.386317$**

```R
library(dplyr)
x <- filter(dat, Sex=="F", Diet=="chow") %>% 
  select(Bodyweight) %>%
  unlist()

y <- filter(dat, Sex=="F", Diet=="hf") %>%
  select(Bodyweight) %>%
  unlist()

set.seed(2)
X <- sample(x, 25)

set.seed(2)
Y <- sample(y, 25)

abs( (mean(y) - mean(x)) - (mean(Y) - mean(X)) )
```

