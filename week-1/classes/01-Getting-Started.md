---
layout: page
title: Getting Started
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

# Getting Started

The first homework assignment is to complete an R tutorial to familiarize yourself with the basics of programming and R syntax. To follow this course you should be familiar with the difference between lists (including data frames) and numeric vectors, for-loops, how to create functions, and how to use the `sapply` and `replicate` functions. 

If you are already familiar with R, you can skip to the next section. Otherwise, you should go through the [swirl](http://swirlstats.com/) tutorial, which teaches you R programming and data science interactively, at your own pace and in the R console. Once you have R installed, you can install `swirl` and run it the following way: 

```R
install.packages("swirl")
library(swirl)
swirl()
```

Two key things you need to know about R is that you can get help for a function using `help` or `?`, like this:

```R
?install.packages
help("install.packages")
```

and the hash character represents comments, so text following these
characters is not interpreted:

```R
##This is just a comment
```

## Installing Packages

The first R command we will run is `install.packages`. If you took the
`swirl` tutorial you should have already done this. R only includes a basic set of functions. It can do much more than this, but not everybody needs everything so we instead make some functions available via packages. Many of these functions are stored in CRAN. Note that these packages are vetted: they are checked for common errors and they must have a dedicated maintainer. You can easily install packages from within R if you know the name of the packages. As an example, we are going to install the package `rafalib` which we use in our first data
analysis examples: 

```R
install.packages("rafalib")
```

We can then load the package into our R sessions using the `library` function:

```R
library(rafalib)
```

From now on you will see that we sometimes load packages without
installing them. This is because once you install the package, it
remains in place and only needs to be loaded with `library`. If you
try to load a package and get an error, it probably means you need to
install it first.

## Important Usage Tips

### Executing Commands: Command Line *vs* R File

We can actually execute commands in the command line, and that's where R is running. Now, throughout the course and - it's something that we highly recommend – if you're doing data analysis, we don't type commands directly in the R window. We open up a file. Go to the upper bar menu: File > New File > [Insert File Name] and you save commands in that file for later.

### How to Run R Scripts

One important aspect of RStudio that you should know right away is that the way that you get the lines of code in an R file to run in the window below is there is a keystroke that lets you do that. On a Mac, it's `Command` $+$ `Return`. You definitely want to find out what that is early on, so that you don't actually have to copy and paste it, you just hit the shourtcut and it automatically runs that command.