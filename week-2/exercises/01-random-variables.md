---
title: "Random Variables and Probability Distributions - Week 2"
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

## Random Variables Exercises

For these exercises, we will be using the following dataset:

```R
library(downloader) 
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleControlsPopulation.csv"
filename <- basename(url)
download(url, destfile=filename)
x <- unlist( read.csv(filename) )
```

Here `x` represents the weights for the entire population.

Make sure that you are using the correct random number generator (RNG) settings by calling the following command:

```R
RNGkind("Mersenne-Twister", "Inversion", "Rejection")
```

### Random Variables Exercises #1

What is the average of these weights? **Answer: $23.89338$**

```R
mean(x)
```

### Random Variables Exercises #2

Set the seed to $1$:

```R
set.seed(1)
```

Take a random sample of size $5$. What is the absolute value (use `abs()`) of the difference between the average of the sample and the average of all the values? **Answer: $0.3293778$**

```R
set.seed(1)
X <- sample(x,5)
abs( mean(X) - mean(x) )
```

### Random Variables Exercises #3

After setting the seed at $5$, `set.seed(5)`, take a random sample of size $5$. What is the absolute value of the difference between the average of the sample and the average of all the values? **Answer: $0.3813778$**

```R
set.seed(5)
X <- sample(x,5)
abs( mean(X) - mean(x) )
```

### Random Variables Exercises #4

Why are the answers from 2 and 3 different? **Answer: Because the average of the samples is a random variable.**


