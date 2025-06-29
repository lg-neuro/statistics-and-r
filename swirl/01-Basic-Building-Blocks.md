# Basic Building Blocks

In this lesson, we will explore some basic building blocks of the $R$ programming language.

If at any point you'd like more information on a particular topic related to $R$, you can type `help.start()` at the prompt, which will open a menu of resources (either within RStudio or your default web browser, depending on your setup). Alternatively, a simple web search often yields the answer you're looking for.

## $R$ as an Interactive Calculator

In its simplest form, $R$ can be used as an interactive calculator.

```R
> 5 + 7
[1] 12
```

$R$ simply prints the result of $12$ by default. However, $R$ is a programming language and often the reason we use a programming language as opposed to a calculator is to automate some process or avoid unnecessary repetition.

## Variables and Assignment

In this case, we may want to use our result from above in a second calculation. Instead of retyping `5 + 7` every time we need it, we can just create a new variable that stores the result.

The way you assign a value to a variable in $R$ is by using the **assignment operator**, which is just a 'less than' symbol followed by a 'minus' sign. It looks like this: `<-`

Think of the assignment operator as an arrow. You are assigning the value on the right side of the arrow to the variable name on the left side of the arrow.

To assign the result of $5 + 7$ to a new variable called $x$, you type `x <- 5 + 7`. This can be read as '$x$ gets $5$ plus $7$'.

```R
> x <- 5 + 7
```

You'll notice that $R$ did not print the result of $12$ this time. When you use the assignment operator, $R$ assumes that you don't want to see the result immediately, but rather that you intend to use the result for something else later on.

To view the contents of the variable $x$, just type $x$ and press Enter.

```R
> x
[1] 12
```

Now, store the result of $x - 3$ in a new variable called $y$.

```R
> y <- x - 3
```

What is the value of $y$?

```R
> y
[1] 9
```

## Vectors

Now, let's create a small collection of numbers called a **vector**. Any object that contains data is called a *data structure* and numeric vectors are the simplest type of data structure in $R$. In fact, even a single number is considered a vector of length one.

### Creating Vectors with `c()` Function

The easiest way to create a vector is with the `c()` function, which stands for *'concatenate'* or *'combine'*. To create a vector containing the numbers $1.1$, $9$, and $3.14$, type `c(1.1, 9, 3.14)`. Store the result in a variable called $z$.

```R
> z <- c(1.1, 9, 3.14)
```

### Getting Help

Anytime you have questions about a particular function, you can access $R$'s built-in help files via the `?` command. For example, if you want more information on the `c()` function, type `?c` without the parentheses that normally follow a function name.

```R
> ?c
```

Type $z$ to view its contents. Notice that there are no commas separating the values in the output.

```R
> z
[1] 1.10 9.00 3.14
```

### Combining Vectors

You can combine vectors to make a new vector. Create a new vector that contains $z$, $555$, then $z$ again in that order.

```R
> c(z, 555, z)
[1]   1.10   9.00   3.14 555.00   1.10   9.00   3.14
```

## Arithmetic Operations with Vectors

Numeric vectors can be used in arithmetic expressions. Type the following to see what happens: `z * 2 + 100`.

```R
> z*2+100
[1] 102.20 118.00 106.28
```

First, $R$ multiplied each of the three elements in $z$ by $2$. Then it added $100$ to each element to get the result you see above.

Other common arithmetic operators are `+`, `-`, `/`, and `^` (where $x^2$ means '$x$ squared'). To take the square root, use the `sqrt()` function and to take the absolute value, use the `abs()` function.

Take the square root of $z - 1$ and assign it to a new variable called $my\_sqrt$.

```R
> my_sqrt <- sqrt(z - 1)
```

Before we view the contents of the $my\_sqrt$ variable, what do you think it contains? A vector of length $3$[^1].

[^1]: As you may have guessed, $R$ first subtracted $1$ from each element of $z$, then took the square root of each element. This leaves you with a vector of the same length as the original vector $z$.

Print the contents of $my\_sqrt$.

```R
> my_sqrt
[1] 0.3162278 2.8284271 1.4628739
```

Now, create a new variable called $my\_div$ that gets the value of $z$ divided by $my\_sqrt$.

```R
> my_div <- z/my_sqrt
```

Which statement do you think is true? The first element of $my\_div$ is equal to the first element of $z$ divided by the first element of $my\_sqrt$, and so on...

```R
> my_div
[1] 3.478505 3.181981 2.146460
```

## Vector Recycling

When given two vectors of the same length, $R$ simply performs the specified arithmetic operation (`+`, `-`, `*`, etc.) element-by-element. If the vectors are of different lengths, $R$ *'recycles'* the shorter vector until it is the same length as the longer vector.

When we did `z * 2 + 100` in our earlier example, $z$ was a vector of length $3$, but technically $2$ and $100$ are each vectors of length $1$.

Behind the scenes, $R$ is *'recycling'* the $2$ to make a vector of $2$s and the $100$ to make a vector of $100$s. In other words, when you ask $R$ to compute `z * 2 + 100`, what it really computes is this: `z * c(2, 2, 2) + c(100, 100, 100)`.

To see another example of how this vector *'recycling'* works, try adding `c(1, 2, 3, 4)` and `c(0, 10)`.

```R
> c(1,2,3,4) + c(0,10)
[1]  1 12  3 14
```

If the length of the shorter vector does not divide evenly into the length of the longer vector, $R$ will still apply the *'recycling'* method, but will throw a warning to let you know something fishy might be going on.

Try `c(1, 2, 3, 4) + c(0, 10, 100)` for an example.

```R
> c(1,2,3,4) + c(0,10,100)
[1]   1  12 103   4
Warning message:
In c(1, 2, 3, 4) + c(0, 10, 100) :
  longer object length is not a multiple of shorter object length
```

## Time-Saving Tricks

Before concluding this lesson, I'd like to show you a couple of time-saving tricks.

Earlier in the lesson, you computed `z * 2 + 100`. Let's pretend that you made a mistake and that you meant to add $1000$ instead of $100$. You could either re-type the expression, or use the **up arrow** key.

In many programming environments, the up arrow will cycle through previous commands. Try hitting the up arrow on your keyboard until you get to this command (`z * 2 + 100`), then change $100$ to $1000$ and hit Enter.

```R
> z*2+1000
[1] 1002.20 1018.00 1006.28
```

Finally, let's pretend you'd like to view the contents of a variable that you created earlier, but you can't seem to remember if you named it $my\_div$ or $myDiv$. You could try both and see what works, or use **auto-completion**.

You can type the first two letters of the variable name, then hit the Tab key (possibly more than once). Most programming environments will provide a list of variables that you've created that begin with 'my'. This is called *auto-completion* and can be quite handy when you have many variables in your workspace.

```R
> my_div
[1] 3.478505 3.181981 2.146460
```