---
title: "Cetral Limit Theorem - Week 2"
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

## Central Limit Theorem Exercises

For these exercises, we will be using the following dataset:

```R
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/mice_pheno.csv"
filename <- basename(url)
download(url, destfile=filename)
dat <- na.omit( read.csv(filename) )
```

### Central Limit Theorem Exercises #1

If a list of numbers has a distribution that is well approximated by the normal distribution, what proportion of these numbers are within one standard deviation away from the list's average?. (Hint: Use the `pnorm()` function. You can look up more information with `?pnorm`.) **Answer: 0.6826895**

```R
pnorm(1)-pnorm(-1)
```

### Central Limit Theorem Exercises #2

What proportion of these numbers are within two standard deviations away from the list's average? **Answer: 0.9544997**

```R
pnorm(2)-pnorm(-2)
```

### Central Limit Theorem Exercises #3

What proportion of these numbers are within three standard deviations away from the list's average? **Answer: 0.9973002**

```R
pnorm(3)-pnorm(-3)
```

### Central Limit Theorem Exercises #4

Define $y$ to be the weights of males on the control diet. What proportion of the mice are within one standard deviation away from the average weight? (Hint: Remember to use `popsd()` from `**rafalib**` for the population standard deviation.) **Answer: 0.6950673**

```R
library(rafalib)
y <- filter(dat, Sex="M", Diet="chow") %>%
     select(Bodyweight) %>%
     unlist()
y_mean <- mean(y)
y_popsd <- popsd(y)
mean((y > (y_mean - y_popsd)) & (y < (y_mean + y_popsd)))

## OR

y <- filter(dat, Sex=="M" & Diet=="chow") %>% select(Bodyweight) %>% unlist
z <- ( y - mean(y) ) / popsd(y)
mean( abs(z) <=1 )
```

### Central Limit Theorem Exercises #5

What proportion of these numbers are within three standard deviations away from the list's average? **Answer: 0.9461883**

```R
mean( abs(z) <=2)
```

### Central Limit Theorem Exercises #6

What proportion of these numbers are within three standard deviations away from the list's average? **Answer: 0.9461883**

```R
mean( abs(z) <=3)
```

### Central Limit Theorem Exercises #7
Note that the numbers for the normal distribution and our weights are relatively close. Also, notice that we are indirectly comparing quantiles of the normal distribution to quantiles of the mouse weight distribution. We can actually compare all quantiles using a qqplot.

```R
qqnorm(z)
abline(0,1)
```

![qqplot mouse weights vs norm distr](../classes/images/qqplot-mouse-weights-vs-normal-distribution.png)

Which of the following best describes the qq-plot comparing mouse weights to the normal distribution? **Answer: The mouse weights are well approximated by the normal distribution, although the larger values (right tail) are larger than predicted by the normal. This is consistent with the differences seen between question 3 and 6.**

### Central Limit Theorem Exercises #8


