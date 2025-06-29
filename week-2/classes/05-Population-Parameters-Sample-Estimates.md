---
layout: page
title: Populations, parameters, and sample estimates
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

# Introduction to Statistical Inference

Imagine you are tasked with determining if men are taller than women in a population you cannot fully observe. Each measurement costs, say, $\$1,000$, but getting the right answer earns you a prize of, for example, $\$10,000$ or $\$30,000$. How many people should you measure?

One approach is to measure the entire population, perhaps $25,000$ to $30,000$ individuals. While this would guarantee the correct population averages for men and women with no randomness, the cost would be prohibitive. **Statistical inference** offers a powerful alternative: it allows you to answer such questions by examining only a small subset of the population.

## Answering Population Questions from Samples

The core idea of statistical inference is to take a random sample—for example, $10$ women and $10$ men—and use this smaller group to infer characteristics about the entire population.

We can illustrate this with a concrete example. After taking a random sample of $10$ women and $10$ men from a known population, we might observe their individual heights. Calculating the average height for each sample, we might find that the average height of the sampled men is $3.3$ inches greater than that of the sampled women.

Is this the final answer? Can we confidently conclude that men are taller than women by $3.3$ inches based on this single sample? The problem with stopping here is that we don't know what would happen if we took another random sample. Would we again see a difference of $3.3$ inches, or would it be a different number, perhaps even negative?

Statistical inference helps us address this uncertainty without the need for additional costly measurements. It provides methods to decipher how much this observed $3.3$-inch difference could vary if we were to take more samples. This is one of the fundamental questions that statistical inference aims to answer.

## Notations and Key Concepts

Let's introduce some mathematical notation:
* **Population Averages**: We use the Greek letter $\mu$ (mu) to denote the population mean or average. So, $\mu_X$ would be the average height of all men in the population (e.g., all $25,000$ men), and $\mu_Y$ would be the average height of all women in the population. These are fixed values that we want to discover.

```math
\mu_X = \frac{1}{m}\sum_{i = 1}^{m}x_i

\;\;\;\;\;\;

\mu_Y = \frac{1}{n}\sum_{i = 1}^{n}y_i
```

* **Sample Observations**: When we take a sample, our observations are denoted by capital letters, like $X$ for men's heights and $Y$ for women's heights, often with an index (e.g., $X_1, X_2, \ldots, X_M$ for men and $Y_1, Y_2, \ldots, Y_M$ for women) to represent individual sampled members.

* **Sample Averages**: The average of the heights from our $10$ sampled men is called the sample average, denoted as $\bar{X}$. Similarly, $\bar{Y}$ represents the sample average for women.

```math
\bar{X} = \frac{1}{M}\sum_{i = 1}^{M}X_i

\;\;\;\;\;\;

\bar{Y} = \frac{1}{N}\sum_{i = 1}^{N}Y_i
```

There is a crucial distinction: $\bar{X}$ and $\bar{Y}$ are averages of the *sample*, whereas $\mu_x$ and $\mu_y$ are averages of the *entire population*. A key question in statistical inference is: how close is a sample average to its corresponding population average?

## Random Variables and the Central Limit Theorem

The sample averages ($\bar{X}$ and $\bar{Y}$) and their difference ($\bar{X} - \bar{Y}$) are **random variables**. This means that if we take another sample, these values will change.

The central question that statistical inference, particularly the **Central Limit Theorem**, helps us answer is: how much do these sample averages change, and how far away are they likely to be from the true population averages? The Central Limit Theorem, which we will discuss in the next module, is one of the most widely used mathematical results in science, providing a powerful tool to answer these questions without having to collect more expensive data.