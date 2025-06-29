# Subsetting Vectors

In this lesson, we'll see how to extract elements from a vector based on some conditions that we specify.

For example, we may only be interested in the first $20$ elements of a vector, or only the elements that are not `NA`, or only those that are positive or correspond to a specific variable of interest. By the end of this lesson, you'll know how to handle each of these scenarios.

## Index Vectors

I've created for you a vector called $x$ that contains a random ordering of $20$ numbers (from a standard normal distribution) and $20$ `NA`s. Type $x$ now to see what it looks like.

```R
> x
 [1]          NA -0.67476569 -1.86737696          NA          NA -0.91762000          NA -0.78025709
 [9]          NA  0.49712493  0.11853028          NA -0.18568840  0.95389738          NA          NA
[17]  1.18822855          NA          NA  0.73381986          NA          NA          NA          NA
[25]  1.34555749          NA -0.16830939  1.87248060 -0.88637108          NA -0.17645313  1.10996807
[33]  1.56022491          NA          NA          NA          NA  0.34527095 -0.22655101  0.07373777
```

The way you tell $R$ that you want to select some particular elements (i.e. a *'subset'*) from a vector is by placing an *'index vector'* in square brackets immediately following the name of the vector.

For a simple example, try `x[1:10]` to view the first ten elements of $x$.

```R
> x[1:10]
 [1]         NA -0.6747657 -1.8673770         NA         NA -0.9176200         NA -0.7802571         NA
[10]  0.4971249
```

**Index vectors** come in four different flavors – *logical* vectors, vectors of *positive integers*, vectors of *negative integers*, and vectors of *character strings* – each of which we'll cover in this lesson.

## Logical Vectors

Let's start by indexing with logical vectors. One common scenario when working with real-world data is that we want to extract all elements of a vector that are not `NA` (i.e. missing data). Recall that `is.na(x)` yields a vector of logical values the same length as $x$, with `TRUE`s corresponding to `NA` values in $x$ and `FALSE`s corresponding to non-`NA` values in $x$.

What do you think `x[is.na(x)]` will give you?
1. A vector of `TRUE`s and `FALSE`s
2. **A vector of all `NA`s**
3. A vector with no `NA`s
4. A vector of length 0

Prove it to yourself by typing `x[is.na(x)]`.

```R
> x[is.na(x)]
 [1] NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA NA
```

Recall that `!` gives us the **negation** of a logical expression, so `!is.na(x)` can be read as *'is not NA'*. Therefore, if we want to create a vector called $y$ that contains all of the non-`NA` values from $x$, we can use `y <- x[!is.na(x)]`. Give it a try.

```R
> y <- x[!is.na(x)]
> y
 [1] -0.67476569 -1.86737696 -0.91762000 -0.78025709  0.49712493  0.11853028 -0.18568840  0.95389738
 [9]  1.18822855  0.73381986  1.34555749 -0.16830939  1.87248060 -0.88637108 -0.17645313  1.10996807
[17]  1.56022491  0.34527095 -0.22655101  0.07373777
```

Now that we've isolated the non-missing values of $x$ and put them in $y$, we can subset $y$ as we please.

Recall that the expression $y > 0$ will give us a vector of logical values the same length as $y$, with `TRUE`s corresponding to values of $y$ that are greater than zero and `FALSE`s corresponding to values of $y$ that are less than or equal to zero. What do you think `y[y > 0]` will give you?

1. **A vector of all the positive elements of $y$**
2. A vector of length $0$
3. A vector of all `NA`s
4. A vector of all the negative elements of $y$
5. A vector of `TRUE`s and `FALSE`s

Type `y[y > 0]` to see that we get all of the positive elements of $y$, which are also the positive elements of our original vector $x$.

```R
> y[y>0]
 [1] 0.49712493 0.11853028 0.95389738 1.18822855 0.73381986 1.34555749 1.87248060 1.10996807 1.56022491
[10] 0.34527095 0.07373777
```

You might wonder why we didn't just start with `x[x > 0]` to isolate the positive elements of $x$. Try that now to see why.

```R
> x[x>0]
 [1]         NA         NA         NA         NA         NA 0.49712493 0.11853028         NA 0.95389738
[10]         NA         NA 1.18822855         NA         NA 0.73381986         NA         NA         NA
[19]         NA 1.34555749         NA 1.87248060         NA 1.10996807 1.56022491         NA         NA
[28]         NA         NA 0.34527095 0.07373777
```

Since `NA` is not a value, but rather a placeholder for an unknown quantity, the expression $NA > 0$ evaluates to `NA`. Hence we get a bunch of `NA`s mixed in with our positive numbers when we do this.

Combining our knowledge of logical operators with our new knowledge of subsetting, we could do this:

```R
> x[!is.na(x) & x > 0]
 [1] 0.49712493 0.11853028 0.95389738 1.18822855 0.73381986 1.34555749 1.87248060 1.10996807 1.56022491
[10] 0.34527095 0.07373777
```

In this case, we request only values of $x$ that are both non-missing AND (`&`) greater than zero.

## Positive Integers Vectors

I've already shown you how to subset just the first ten values of $x$ using `x[1:10]`. In this case, we're providing a vector of positive integers inside of the square brackets, which tells $R$ to return only the elements of $x$ numbered $1$ through $10$. Many programming languages use what's called *'zero-based indexing'*, which means that the first element of a vector is considered element 0. $R$ uses *'one-based indexing'*, which (you guessed it!) means the first element of a vector is considered element $1$.

Can you figure out how we'd subset the 3rd, 5th, and 7th elements of $x$? Hint -- Use the `c()` function to specify the element numbers as a numeric vector. 

```R
> x[c(3,5,7)]
[1] -1.867377        NA        NA
```

It's important that when using integer vectors to subset our vector $x$, we stick with the set of indexes $\{1, 2, ..., 40\}$ since $x$ only has $40$ elements. What happens if we ask for the zeroth element of $x$ (i.e. `x[0]`)? Give it a try.

```R
> x[0]
numeric(0)
```

As you might expect, we get nothing useful. Unfortunately, $R$ doesn't prevent us from doing this. What if we ask for the 3000th element of x? Try it out.

```R
> x[3000]
[1] NA
```

Again, nothing useful, but $R$ doesn't prevent us from asking for it. This should be a cautionary tale. You should always make sure that what you are asking for is within the bounds of the vector you're working with.

## Negative Integers Vectors

Luckily, $R$ accepts negative integer indexes. Whereas `x[c(2, 10)]` gives us *ONLY* the 2nd and 10th elements of $x$, `x[c(-2, -10)9]` gives us all elements of $x$ *EXCEPT* for the 2nd and 10th elements.  Try `x[c(-2, -10)]` now to see this.

```R
> x[c(-2,-10)]
 [1]          NA -1.86737696          NA          NA -0.91762000          NA -0.78025709          NA
 [9]  0.11853028          NA -0.18568840  0.95389738          NA          NA  1.18822855          NA
[17]          NA  0.73381986          NA          NA          NA          NA  1.34555749          NA
[25] -0.16830939  1.87248060 -0.88637108          NA -0.17645313  1.10996807  1.56022491          NA
[33]          NA          NA          NA  0.34527095 -0.22655101  0.07373777
```

A shorthand way of specifying multiple negative numbers is to put the negative sign out in front of the vector of positive numbers. Type `x[-c(2, 10)]` to get the exact same result.

```R
> x[-c(2,10)]
 [1]          NA -1.86737696          NA          NA -0.91762000          NA -0.78025709          NA
 [9]  0.11853028          NA -0.18568840  0.95389738          NA          NA  1.18822855          NA
[17]          NA  0.73381986          NA          NA          NA          NA  1.34555749          NA
[25] -0.16830939  1.87248060 -0.88637108          NA -0.17645313  1.10996807  1.56022491          NA
[33]          NA          NA          NA  0.34527095 -0.22655101  0.07373777
```

## Character String Vectors

So far, we've covered three types of index vectors -- logical, positive integer, and negative integer. The only remaining type requires us to introduce the concept of *'named'* elements.

### Named elements

Create a numeric vector with three named elements using `vect <- c(foo = 11, bar = 2, norf = NA)`. When we print vect to the console, you'll see that each element has a name. Try it out.

```R
> vect
 foo  bar norf 
  11    2   NA 
```

We can also get the names of $vect$ by passing $vect$ as an argument to the `names()` function. Give that a try.

```R
> names(vect)
[1] "foo"  "bar"  "norf"
```

Alternatively, we can create an unnamed vector $vect2$ with `c(11, 2, NA)`, and just then, we can add the `names` attribute to $vect2$ after the fact with `names(vect2) <- c("foo", "bar", "norf")`. Go ahead.

```R
> vect2 <- c(11,2,NA)
> names(vect2) <- c("foo", "bar", "norf")
```

Now, let's check that $vect$ and $vect2$ are the same by passing them as arguments to the `identical()` function.

```R
> identical(vect, vect2)
[1] TRUE
```

Indeed, $vect$ and $vect2$ are identical named vectors. Now, back to the matter of subsetting a vector by named elements. Which of the following commands do you think would give us the second element of $vect$?

1. **`vect["bar"]`**
2. `vect["2"]`
3. `vect[bar]`

Try it out.

```R
> vect["bar"]
bar 
  2
```

Likewise, we can specify a vector of names with `vect[c("foo", "bar")]`. Try it out.

```R
> vect[c("foo", "bar")]
foo bar 
 11   2 
```

Now you know all four methods of subsetting data from vectors. Different approaches are best in different scenarios and when in doubt, try it out!

