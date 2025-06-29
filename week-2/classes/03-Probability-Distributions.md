---
layout: page
title: Probability Distributions
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

# Probability Distributions

In these modules, we will explore distributions and the powerful concept of the normal approximation. We'll use a dataset of the heights of $1078$ adult men as our example.

## Summarizing Data with Histograms

How do we summarize such a large list of numbers? Presenting all $1078$ individual heights would be inefficient. Instead, we can use a histogram, which we've discussed in a previous module. An histogram provides a highly summarized yet informative picture of the data. For instance, it can show us how many men are $59$ inches tall, $60$ inches tall, and so on, by grouping heights into intervals (typically rounded to the closest inch). This visual summary conveys a significant amount of information about the height distribution without listing every single number.

A histogram can help us compute the proportion of men who are below any given height. If you provide a height `a`, we can quite precisely calculate the proportion of men shorter than `a` using the histogram[^1].

```math
F(a) \equiv \text{Pr}(\text{Height} \leq a)
``` 

[^1]: The cumulative distribution function gives the probability that a random variable (in this case $\text{Height}$) takes a value less than or equal to $a$.

Furthermore, if we know this proportion for every possible height $b$, we can then determine the number of adults whose heights fall between any interval $a$ and $b$ by simply subtracting the proportion for $a$ from the proportion for $b$. Effectively, describing the distribution of a list of numbers provides a comprehensive understanding of that list.

```math
\text{Pr}(a \leq \text{Height} \leq b) = F(b) - F(a)
```

## Empirical Cumulative Distribution Function (ECDF) and Probability

Statisticians use what is called the **empirical cumulative distribution function (ECDF)** to represent this information. The ECDF shows $f(x)$ for any given height $x$, where $f(x)$ represents the proportion of individuals with heights less than or equal to $x$.

This concept extends naturally to probability. If we randomly select an adult male, we can talk about the probability of this person being, say, less than $70$ inches tall. To answer this, we essentially find the proportion of males in the distribution who are shorter than that height. Therefore, knowing the distribution of heights for our population allows us to answer questions about the probability of picking someone at random whose height is shorter than any given $x$, or falls within any interval $a$ to $b$.

In the next module, we will introduce a very useful approximation that, when applicable, allows us to summarize an entire distribution using just two numbers.

#### `code.R`

Script file from this lesson.

```R
## None
```