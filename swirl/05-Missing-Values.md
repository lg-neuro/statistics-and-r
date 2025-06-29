# Missing Values

Missing values play an important role in statistics and data analysis. Often, missing values must not be ignored, but rather they should be *carefully studied* to see if there's an underlying *pattern* or *cause* for their missingness.

## NA

In R, `NA` is used to represent any value that is *'not available'* or *'missing'* (in the statistical sense). In this lesson, we'll explore missing values further.

Any operation involving `NA` generally yields `NA` as the result. To illustrate, let's create a vector `c(44, NA, 5, NA)` and assign it to a variable `x`.

```R
> x <- c(44, NA, 5, NA)
```

Now, let's multiply `x` by 3.

```R
> x*3
[1] 132  NA  15  NA
```

Notice that the elements of the resulting vector that correspond with the `NA` values in `x` are also `NA`.

### `rnorm()`

To make things a little more interesting, lets create a vector containing 1000 draws from a standard normal distribution with `y <- rnorm(1000)`.

```R
> y <- rnorm(1000)
```

Next, let's create a vector containing 1000 `NA`s with `z <- rep(NA, 1000)`.

```R
> z <- rep(NA, 1000)
```

### `sample()`

Finally, let's select 100 elements at random from these 2000 values (combining `y` and `z`) such that we don't know how many `NA`s we'll wind up with or what positions they'll occupy in our final vector.

```R
> my_data <- sample(c(y, z), 100)
```

### `is.na()`

Let's first ask the question of where our NAs are located in our data. The `is.na()` function tells us whether each element of a vector is `NA`. Call `is.na()` on `my_data` and assign the result to `my_na`.

```R
> my_na <- is.na(my_data)
```

Now, print my_na to see what you came up with.

```R
> my_na
  [1]  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE
 [18] FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE
 [35] FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE FALSE FALSE FALSE FALSE FALSE
 [52]  TRUE  TRUE  TRUE FALSE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE
 [69]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE
 [86] FALSE FALSE  TRUE FALSE FALSE FALSE  TRUE FALSE  TRUE FALSE  TRUE  TRUE  TRUE FALSE  TRUE
```

### `NA != NA`

Everywhere you see a `TRUE`, you know the corresponding element of `my_data` is `NA`. Likewise, everywhere you see a `FALSE`, you know the corresponding element of `my_data` is one of our random draws from the standard normal distribution.

In our previous discussion of logical operators, we introduced the `==` operator as a method of testing for equality between two objects. So, you might think the expression `my_data == NA` yields the same results as `is.na()`. Give it a try.

```R
> my_data == NA
  [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
 [35] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
 [69] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
```

The reason you got a vector of all `NA`s is that `NA` is not really a value, but just a placeholder for a quantity that is not available. Therefore the logical expression is incomplete and R has no choice but to return a vector of the same length as `my_data` that contains all `NA`s.

Don't worry if that's a little confusing. The key takeaway is to be cautious when using logical expressions anytime `NA`s might creep in, since a single `NA` value can derail the entire thing.

### `sum()`

So, back to the task at hand. Now that we have a vector, `my_na`, that has a `TRUE` for every `NA` and `FALSE` for every numeric value, we can compute the total number of NAs in our data.

The trick is to recognize that underneath the surface, R represents `TRUE` as the number 1 and `FALSE` as the number 0. Therefore, if we take the sum of a bunch of `TRUE`s and `FALSE`s, we get the total number of `TRUE`s.

Let's give that a try here. Call the `sum()` function on `my_na` to count the total number of `TRUE`s in `my_na`, and thus the total number of `NA`s in `my_data`. Don't assign the result to a new variable.

```R
> sum(my_na)
[1] 52
```

Pretty cool, huh? Finally, let's take a look at the data to convince ourselves that everything 'adds up'. Print `my_data` to the console.

```R
> my_data
  [1]           NA  1.792903920           NA  0.561707437           NA           NA           NA
  [8] -0.761336106 -0.457084409  1.154108801           NA -0.230263509           NA  0.098718913
 [15] -0.646437559  1.252108678 -0.566550250 -1.260764840 -0.890209150           NA -0.008203202
 [22] -1.617235589           NA           NA -0.670428095  0.493753937           NA -0.067360896
 [29]  0.355249422  0.688461739 -2.327347308  0.374611531  0.650017681           NA -0.657138644
 [36] -0.325875786           NA           NA           NA           NA -0.054094747           NA
 [43]           NA           NA -0.846395935           NA  1.519406167  1.003135965  0.411223620
 [50] -0.964945759 -1.077487846           NA           NA           NA -0.957365353  2.059285565
 [57] -1.160638241           NA           NA -2.208229322           NA  0.741373855           NA
 [64]           NA           NA  0.685738787           NA           NA           NA           NA
 [71]           NA           NA           NA           NA           NA -0.301155895           NA
 [78]  0.097762948           NA           NA           NA           NA           NA -0.284584986
 [85]           NA  0.139893463 -0.688047632           NA  0.457809360 -0.722156062  0.725263725
 [92]           NA  1.637748428           NA  0.186444046           NA           NA           NA
 [99] -0.756624449           NA
```

## NaN

Now that we've got `NA`s down pat, let's look at a second type of missing value – `NaN`, which stands for '*not a number'*. To generate `NaN`, try dividing (using a forward slash) 0 by 0 now.

```R
> 0/0
[1] NaN
```

Let's do one more, just for fun. In R, `Inf` stands for infinity. What happens if you subtract `Inf` from `Inf`?

```R
> Inf-Inf
[1] NaN
```
