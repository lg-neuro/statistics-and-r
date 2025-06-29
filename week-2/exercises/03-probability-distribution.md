---
title: "Random Variables and Probability Distributions - Week 2"
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

## Probability Distributions Exercises

In the video you just watched, Rafa looked at distributions of heights, and asked what was the probability of someone being shorter than a given height. In this assessment, we are going to ask the same question, but instead of people and heights, we are going to look at whole countries and the average life expectancy in those countries.

We will use the data set called "Gapminder" which is available as an R-package on Github. This data set contains the life expectancy, GDP per capita, and population by country, every five years, from $1952$ to $2007$. It is an excerpt of a larger and more comprehensive set of data available on [Gapminder.org](https://www.gapminder.org), and the R package of this dataset was created by the statistics professor [Jennifer Bryan](http://www.stat.ubc.ca/~jenny/).

First, install the gapminder data using:

```R
install.packages("gapminder")
```

Next, load the gapminder data set. To find out more information about the data set, use `?gapminder` which will bring up a help file. To return the first few lines of the data set, use the function `head()`.

```R
library(gapminder)
data(gapminder)
head(gapminder)
```

Create a vector $x$ of the life expectancies of each country for the year $1952$. Plot a histogram of these life expectancies to see the spread of the different countries.

### Probability Distributions Exercises #1

In statistics, the empirical cumulative distribution function (or empirical cdf or empirical distribution function) is the function $F(a)$ for any $a$, which tells you the proportion of the values which are less than or equal to $a$.

We can compute $F$ in two ways: the simplest way is to type `mean(x <= a)`. This calculates the number of values in $x$ which are less than or equal to $a$, divided by the total number of values in $x$, in other words the proportion of values less than or equal to $a$.

The second way, which is a bit more complex for beginners, is to use the `ecdf()` function. This is a bit complicated because this is a function that doesn't return a value, but a function.

Let's continue, using the simpler `mean()` function.

What is the proportion of countries in $1952$ that have a life expectancy less than or equal to 40? **Answer: $0.2887324$**

```R
dat1952 = gapminder[ gapminder$year == 1952, ]
x = dat1952$lifeExp
mean(x <= 40)
```