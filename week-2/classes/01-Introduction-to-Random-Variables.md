---
layout: page
title: Introduction to Random Variables
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

# Introduction to Random Variables

## Statistical Inference: Interpreting Experimental Results

**Statistical inference** is crucial for drawing scientific conclusions from experimental data. We'll explore these concepts by examining a [paper](https://diabetesjournals.org/diabetes/article/53/suppl_3/S215/13869/The-High-Fat-Diet-Fed-MouseA-Model-for-Studying) published in the journal *Diabetes*, which reports on an experiment involving mice and different diet. A key conclusion from this paper's abstract is that "body weight was higher in mice that were fed the high-fat diet already after the first week". Understanding how such conclusions are reached, and the role of statistical inference, is our goal.

## Deciphering Scientific Conclusions

In the results section of the paper, you'll encounter statements like "body weight was $16.3 \pm 0.1$" and "we found differences of $2 \pm 1$, and then there is "P less than $0.001$". The "**$\pm$**" represents a measure of variability, and the "P less than $0.001$" refers to a **P-value**, both key concepts in statistical inference that we will describe in this course.

To understand how these conclusions are formed, we'll perform a similar analysis. Our goal is to determine if a high-fat diet indeed makes mice heavier. This involves collecting data through a controlled experiment:

* We obtain, for example, $24$ mice from Jackson Laboratories.
* These mice are randomly selected.
* 12 mice are fed a high-fat diet, and the other $12$ receive a control diet.
* Finally, we compare the two groups.

The dataset we've been using in previous lessons is derived from such an experiment. We can load this data using `read.csv()` and then use `dplyr` commands to separate the control measurements from those of the high-fat diet group. After running these commands, we will have two lists of numbers: one for the control group and one for the high-fat treatment group.

```R
library(dplyr)
dat <- read.csv("femaleMiceWeights.csv")

control <- filter(dat,Diet=="chow") %>%
  select(Bodyweight) %>% unlist

treatment <- filter(dat,Diet=="hf") %>%
  select(Bodyweight) %>% unlist
```

Upon comparing individual mice, you might observe that a high-fat diet mouse isn't always heavier than a control mouse; there can be instances where a high-fat diet mouse is lighter. Therefore, when we make scientific statements like "a high-fat diet makes mice heavier," we are referring to a comparison of the *average* body weight between the groups.

By comparing the mean of the treatment group to the mean of the control group, we might find that, on average, the treatment group is approximately $3$ grams heavier than the control group.

```R
> mean(treatment) - mean(control)
[1] 3.020833
```

## The Role of Random Variables

The "$\pm$" values and P-values presented in scientific papers arise because the specific mean values (e.g., $26$ for treatment, $23$ for control) we obtain from one experiment are not absolute. If we were to repeat the experiment with a different group of $12$ randomly selected mice, the average body weights for both groups would likely change slightly. This is because these averages are, in statistical terms, **random variables**. In science, we must be skeptical. We need to question whether this observed difference is genuinely due to the diet or simply a result of chance. This is where the concept of a random variable becomes crucial.

## Simulating Random Samples from a Population

In this specific example, we have a rare advantage: access to the *entire* population of control mice available from Jackson Lab workers, along with their weights. We can load this `femaleControlsPopulation.csv` dataset, which contains $225$ mouse weights, and convert it into a numeric vector using the `unlist()` function.

```R
population <- read.csv("femaleControlsPopulation.csv") %>% unlist()
```

Now, let's observe what a random variable means in practice. R has a `sample()` function that allows you to take a random sample of a specified size from a list of numbers. If we take a random sample of $12$ mice from our `population` (the entire control population) and compute their mean, we might get a value like $24.7$. This is different from the mean of our initial control group ($23.8$) or the treatment group ($26.8$) from our experiment.

```R
> mean(sample(population, 12))
[1] 23.445
> mean(control)
[1] 23.81333
> mean(treatment)
[1] 26.83417
```

The key insight is that if you repeat this sampling process over and over again, each time you'll get a different set of $12$ mice and, consequently, a different mean. This fluctuation in the sample mean due to random sampling is what defines it as a **random variable**.

```R
> mean(sample(population, 12))
[1] 24.61667
> mean(sample(population, 12))
[1] 23.195
> mean(sample(population, 12))
[1] 24.14417
```

## Connecting Random Variables to Scientific Questions

This concept of a fluctuating random variable is vital for statistical inference, helping us answer questions like: was the observed difference truly due to the high-fat diet, or was it just a result of chance? Because we have access to the entire population in this simulation, we can see how the random variable behaves repeatedly.

In a real-world experiment, you typically only get to see one set of $12$ mice and their mean. However, it's crucial to remember that you *could have* obtained a different set of $12$ mice, and thus, a different mean. Therefore, the mean you observe from your single experiment should be thought of as a random variable.

In the next lesson, we'll demonstrate how we can begin to answer whether an observed difference of $3$ grams could occur purely by chance. Following that, we'll construct a **null distribution** based on these random variables to further understand the role of chance in our observations.

#### `code.R`

Script file from this lesson.

```R
library(dplyr)
dat <- read.csv("femaleMiceWeights.csv")

control <- filter(dat,Diet=="chow") %>%
  select(Bodyweight) %>% unlist

treatment <- filter(dat,Diet=="hf") %>%
  select(Bodyweight) %>% unlist

mean(treatment) - mean(control)

population <- read.csv("femaleControlsPopulation.csv") %>% unlist()

population <- unlist(population)


mean(sample(population, 12))
mean(control)
mean(treatment)
```
