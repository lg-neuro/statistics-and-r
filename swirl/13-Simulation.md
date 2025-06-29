# Simulation

One of the great advantages of using a statistical programming language like $R$ is its vast collection of tools for simulating random numbers.

This lesson assumes familiarity with a few common probability distributions, but these topics will only be discussed with respect to random number generation. Even if you have no prior experience with these concepts, you should be able to complete the lesson and understand the main ideas.

## `sample()` Function

The first function we'll use to generate random numbers is `sample()`. Use `?sample` to pull up the documentation.

### Rolling Dice

Let's simulate rolling four six-sided dice:

```R
> sample(1:6, 4, replace = TRUE)
[1] 6 4 2 3
```

Now repeat the command to see how your result differs. (The probability of rolling the exact same result is $(1/6)^4 = 0.00077$, which is pretty small!)

```R
> sample(1:6, 4, replace = TRUE)  
[1] 1 4 1 5
```

`sample(1:6, 4, replace = TRUE)` instructs $R$ to randomly select four numbers between $1$ and $6$, *WITH* replacement. Sampling with replacement simply means that each number is *"replaced"* after it is selected, so that the same number can show up more than once. This is what we want here, since what you roll on one die shouldn't affect what you roll on any of the others.

### Sampling Without Replacement

Now sample $10$ numbers between $1$ and $20$, *WITHOUT* replacement. To sample without replacement, simply leave off the `replace` argument.

```R
> sample(1:20, 10)
 [1] 19  4  3  6  7 13  5 11 14 12
```

Since the last command sampled without replacement, no number appears more than once in the output.

### Permutation

`LETTERS` is a predefined variable in $R$ containing a vector of all $26$ letters of the English alphabet. Take a look at it now.

```R
> LETTERS
 [1] "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" "U" "V" "W" "X" "Y" "Z"
```

The `sample()` function can also be used to permute, or rearrange, the elements of a vector. For example, try `sample(LETTERS)` to permute all $26$ letters of the English alphabet.

```R
> sample(LETTERS)
 [1] "K" "N" "D" "H" "E" "T" "J" "P" "O" "G" "X" "B" "Y" "S" "U" "C" "M" "Z" "W" "Q" "V" "F" "A" "L" "I" "R"
```

This is identical to taking a sample of size $26$ from `LETTERS`, without replacement. When the `size` argument to `sample()` is not specified, $R$ takes a sample equal in size to the vector from which you are sampling.

### Uneven probabilities

Now, suppose we want to simulate $100$ flips of an unfair two-sided coin. This particular coin has a $0.3$ probability of landing 'tails' and a $0.7$ probability of landing 'heads'.

Let the value $0$ represent tails and the value $1$ represent heads. Use `sample()` to draw a sample of size $100$ from the vector `c(0,1)`, with replacement. Since the coin is unfair, we must attach specific probabilities to the values $0$ (tails) and $1$ (heads) with a fourth argument, `prob = c(0.3, 0.7)`. Assign the result to a new variable called $flips$.

```R
> flips <- sample(c(0,1), 100, replace = TRUE, prob = c(0.3, 0.7))
```

View the contents of the $flips$ variable.

```R
> flips
  [1] 1 0 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 1 1 0 0 1 0 0 0 1 1 1 1 0 0 1 1 1 0 1 1 1 0 0 1
 [52] 1 1 1 1 0 1 1 1 1 1 1 0 1 1 1 1 1 0 1 1 1 1 0 0 1 1 1 1 1 1 1 1 1 0 1 0 1 1 0 0 1 1 1 1 0 1 1 0 0
```

Since we set the probability of landing heads on any given flip to be $0.7$, we'd expect approximately $70$ of our coin flips to have the value $1$. Count the actual number of $1$s contained in $flips$ using the `sum()` function.

```R
> sum(flips)
[1] 74
```

## Binomial Distribution

A coin flip is a binary outcome ($0$ or $1$) and we are performing $100$ independent trials (coin flips), so we can use `rbinom()` to simulate a binomial random variable. Pull up the documentation for `rbinom()` using `?rbinom`.

Each probability distribution in $R$ has an `r***` function (for *"random"*), a `d***` function (for *"density"*), a `p***` (for *"probability"*), and `q***` (for *"quantile"*). We are most interested in the `r***` functions in this lesson, but I encourage you to explore the others on your own.

### Single Binomial Variable

A binomial random variable represents the number of *'successes'* (heads) in a given number of independent *'trials'* (coin flips). Therefore, we can generate a single random variable that represents the number of heads in $100$ flips of our unfair coin using `rbinom(1, size = 100, prob = 0.7)`. Note that you only specify the probability of *'success'* (heads) and NOT the probability of *'failure'* (tails). Try it now.

```R
> rbinom(1, size = 100, prob = 0.7)
[1] 69
```

### Multiple Observations

Equivalently, if we want to see all of the $0$s and $1$s, we can request $100$ observations, each of size $1$, with success probability of $0.7$. Give it a try, assigning the result to a new variable called $flips2$.

```R
> flips2 <- rbinom(100, size = 1, prob = 0.7)
```

View the contents of $flips2$.

```R
> flips2
  [1] 1 1 0 1 1 0 1 1 1 1 1 1 0 1 0 0 1 1 1 1 1 1 1 1 1 0 1 1 1 1 1 1 1 1 0 1 1 0 0 0 1 1 1 0 1 1 1 0 0 1 1
 [52] 1 1 1 1 1 1 1 1 1 1 1 1 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 0 1 1 0 1 0 1 1 1 0 1 1 1 1 1 1
```

Now use `sum()` to count the number of $1$s (heads) in $flips2$. It should be close to $70$!

```R
> sum(flips2)
[1] 80
```

## Normal Distribution

Similar to `rbinom()`, we can use $R$ to simulate random numbers from many other probability distributions. Pull up the documentation for `rnorm()` now.

The standard normal distribution has mean $0$ and standard deviation $1$. As you can see under the *'Usage'* section in the documentation, the default values for the `mean` and `sd` arguments to `rnorm()` are $0$ and $1$, respectively. Thus, `rnorm(10)` will generate $10$ random numbers from a standard normal distribution. Give it a try.

```R
> rnorm(10)
 [1]  0.2151391  0.9100582 -1.1891998 -0.1359332  1.9082314 -0.6882760 -0.3228013  0.3756945  0.7973116
[10]  1.0328361
```

Now do the same, except with a mean of $100$ and a standard deviation of $25$.

```R
> rnorm(10, mean = 100, sd = 25)
 [1] 136.93529  94.48675  86.35630  93.55248 103.00567  74.53472 114.42127 115.02844  89.31691  97.89498
```

## Poisson Distribution and `replicate()` Function

Finally, what if we want to simulate $100$ *groups* of random numbers, each containing $5$ values generated from a Poisson distribution with mean $10$? Let's start with one group of $5$ numbers, then I'll show you how to repeat the operation $100$ times in a convenient and compact way.

Generate $5$ random values from a Poisson distribution with mean $10$. Check out the documentation for `rpois()` if you need help.

```R
> rpois(5, 10)
[1] 11  9 13  8 14
```

Now use `replicate(100, rpois(5, 10))` to perform this operation $100$ times. Store the result in a new variable called $my\_pois$.

```R
> my_pois <- replicate(100, rpois(5, 10))
```

Take a look at the contents of $my\_pois$.

```R
> my_pois
     [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10] [,11] [,12] [,13] [,14] [,15] [,16] [,17] [,18]
[1,]    7   12    9   13    5   14    7    9   14    11    17     8    11    12    14     7    14    10
[2,]   11    8    8    9   11    9    9   14   12    13     9    13    13    10     8     9     8    15
[3,]    7    6   13    6   16    9   12   10    8     8    12     6    12    11     7    13     4    11
[4,]    6    7    9    4    8   13   14   10    9    11    12     6    12     8    16     9     6     9
[5,]    8   12    9    7   10    6   10    8    8    10     6     7     8     7    10    11     9     9
...
```

### Column Means and Central Limit Theorem

`replicate()` created a matrix, each column of which contains $5$ random numbers generated from a Poisson distribution with mean $10$. Now we can find the mean of each column in $my\_pois$ using the `colMeans()` function. Store the result in a variable called $cm$.

```R
> cm <- colMeans(my_pois)
```

And let's take a look at the distribution of our column means by plotting a histogram with `hist(cm)`.

```R
> hist(cm)
```

Looks like our column means are almost normally distributed, right? That's the Central Limit Theorem at work, but that's a lesson for another day!

## Other Probability Distributions

All of the standard probability distributions are built into $R$, including exponential (`rexp()`), chi-squared (`rchisq()`), gamma (`rgamma()`), .... Well, you see the pattern.

Simulation is practically a field of its own and we've only skimmed the surface of what's possible. I encourage you to explore these and other functions further on your own.