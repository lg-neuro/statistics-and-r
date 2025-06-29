# `vapply()` and `tapply()`

In the last lesson, you learned about the two most fundamental members of $R$'s `*apply` family of functions: `lapply()` and `sapply()`. Both take a list as input, apply a function to each element of the list, then combine and return the result. `lapply()` always returns a list, whereas `sapply()` attempts to simplify the result.

In this lesson, you'll learn how to use `vapply()` and `tapply()`, each of which serves a very specific purpose within the Split-Apply-Combine methodology. For consistency, we'll use the same dataset we used in the 'lapply and sapply' lesson.

## The Flags Dataset

The Flags dataset from the UCI Machine Learning Repository contains details of various nations and their flags. More information may be found here: http://archive.ics.uci.edu/ml/datasets/Flags

I've stored the data in a variable called $flags$. If it's been a while since you completed the 'lapply and sapply' lesson, you may want to reacquaint yourself with the data by using functions like `dim()`, `head()`, `str()`, and `summary()` when you return to the prompt (`>`). You can also type `viewinfo()` at the prompt to bring up some documentation for the dataset.

## `vapply()` Function

As you saw in the last lesson, the `unique()` function returns a vector of the unique values contained in the object passed to it. Therefore, `sapply(flags, unique)` returns a list containing one vector of unique values for each column of the $flags$ dataset.

```R
> sapply(flags, unique)
$name
  [1] "Afghanistan"              "Albania"                  "Algeria"                  "American-Samoa"           "Andorra"                  "Angola"                  
...
```

### `vapply()` is a Safer Alternative to `sapply()`

What if you had forgotten how `unique()` works and mistakenly thought it returns the *number* of unique values contained in the object passed to it? Then you might have incorrectly expected `sapply(flags, unique)` to return a numeric vector, since each element of the list returned would contain a single number and `sapply()` could then simplify the result to a vector.

When working interactively (at the prompt), this is not much of a problem, since you see the result immediately and will quickly recognize your mistake. However, when working non-interactively (e.g. writing your own functions), a misunderstanding may go undetected and cause incorrect results later on. Therefore, you may wish to be more careful and that's where `vapply()` is useful. 

Whereas `sapply()` tries to "guess" the correct format of the result, `vapply()` allows you to specify it explicitly. If the result doesn't match the format you specify, `vapply()` will throw an error, causing the operation to stop. This can prevent significant problems in your code that might be caused by getting unexpected return values from `sapply()`.

Try `vapply(flags, unique, numeric(1))`, which says that you expect each element of the result to be a numeric vector of length $1$. Since this is NOT actually the case, YOU WILL GET AN ERROR.

```R
> vapply(flags, unique, numeric(1))
Error in vapply(flags, unique, numeric(1)) : values must be length 1,
 but FUN(X[[1]]) result is length 194
```

### Using `vapply()` Correctly

Recall from the previous lesson that `sapply(flags, class)` will return a character vector containing the class of each column in the dataset.

```R
> sapply(flags, class)
       name    landmass        zone        area  population    language    religion        bars     stripes     colours         red       green        blue        gold 
...
```

If we wish to be explicit about the format of the result we expect, we can use `vapply(flags, class, character(1))`. The `character(1)` argument tells R that we expect the class function to return a character vector of length $1$ when applied to EACH column of the $flags$ dataset.

```r
> vapply(flags, class, character(1))
       name    landmass        zone        area  population    language    religion        bars     stripes     colours         red       green        blue        gold 
...
```

Note that since our expectation was correct (i.e. `character(1)`), the `vapply()` result is identical to the `sapply()` result -- a character vector of column classes.

### When to Use `vapply()`

You might think of `vapply()` as being *safer* than `sapply()`, since it requires you to specify the format of the output in advance, instead of just allowing $R$ to "guess" what you wanted. In addition, `vapply()` may perform faster than `sapply()` for large datasets. However, when doing data analysis interactively (at the prompt), `sapply()` saves you some typing and will often be good enough.

## `tapply()` Function

As a data analyst, you'll often wish to split your data up into groups based on the value of some variable, then apply a function to the members of each group. The next function we'll look at, `tapply()`, does exactly that.

### Understanding the Data Groups

The `landmass` variable in our dataset takes on integer values between $1$ and $6$, each of which represents a different part of the world. Use `table(flags$landmass)` to see how many flags/countries fall into each group.

```R
> table(flags$landmass)
 1  2  3  4  5  6 
31 17 35 52 39 20 
```

The `animate` variable in our dataset takes the value $1$ if a country's flag contains an animate image (e.g. an eagle, a tree, a human hand) and $0$ otherwise. Use `table(flags$animate)` to see how many flags contain an animate image.

```R
> table(flags$animate)
  0   1 
155  39 
```

This tells us that $39$ flags contain an animate object (`animate` $= 1$) and $155$ do not (`animate` $= 0$).

### Using `tapply()` for Group Analysis

If you take the arithmetic mean of a bunch of $0$s and $1$s, you get the proportion of $1$s. Use `tapply(flags$animate, flags$landmass, mean)` to apply the mean function to the `animate` variable separately for each of the six landmass groups, thus giving us the proportion of flags containing an animate image WITHIN each landmass group.

```R
> tapply(flags$animate, flags$landmass, mean)
        1         2         3         4         5         6 
0.4193548 0.1764706 0.1142857 0.1346154 0.1538462 0.3000000 
```

The first landmass group (`landmass` $= 1$) corresponds to North America and contains the highest proportion of flags with an animate image ($0.4194$).

### More Complex Analysis with `tapply()`

Similarly, we can look at a summary of population values (in round millions) for countries with and without the color red on their flag with `tapply(flags$population, flags$red, summary)`.

```R
> tapply(flags$population, flags$red, summary)
$`0`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    3.00   27.63    9.00  684.00 

$`1`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    0.0     0.0     4.0    22.1    15.0  1008.0 
```

The median population (in millions) for countries *without* the color red on their flag is $3.0$.

Lastly, use the same approach to look at a summary of population values for each of the six landmasses.

```R
> tapply(flags$population, flags$landmass, summary)
$`1`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   12.29    4.50  231.00 

$`2`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    1.00    6.00   15.71   15.00  119.00 

$`3`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    8.00   13.86   16.00   61.00 

$`4`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   1.000   5.000   8.788   9.750  56.000 

$`5`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    2.00   10.00   69.18   39.00 1008.00 

$`6`
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   0.00    0.00    0.00   11.30    1.25  157.00 
```

The maximum population (in millions) for the fourth landmass group (Africa) is $56.00$.

## Summary

In this lesson, you learned how to use `vapply()` as a safer alternative to `sapply()`, which is most helpful when writing your own functions. You also learned how to use `tapply()` to split your data into groups based on the value of some variable, then apply a function to each group. These functions will come in handy on your quest to become a better data analyst.