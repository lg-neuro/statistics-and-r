---
layout: page
title: Introduction to dplyr
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

# Introduction to `dplyr`

In data analysis, R comes with a basic set of tools, but for most tasks, you'll need to add **packages** that provide more advanced functionality. These packages extend R's capabilities. Once downloaded, you only need to load them into your R session to access their functions.

The **`dplyr`** package is a powerful example of this. It simplifies data manipulation tasks and makes your code much easier to read and write. We'll be using `dplyr` extensively throughout this course.

## Installing and Loading `dplyr`

If you don't already have `dplyr` installed, you can easily install it using the `install.packages()` function. In your R console or script, type:

```R
install.packages("dplyr")
```

After running this, R will download `dplyr` from CRAN (the Comprehensive R Archive Network) and install it for you. This installation only needs to be done once.

To make the functions within `dplyr` available for use in your current R session, you need to load the package using the `library()` function:

```R
library(dplyr)
```

Now, all the functionalities provided by `dplyr` are ready for your use.

## Basic Data Manipulation with `dplyr`

Let's begin by demonstrating some fundamental `dplyr` commands using a sample dataset. We'll read in a CSV file containing mouse weights, which has two main columns: `diet` and `bodyweight`. This dataset contains 24 mice divided into two groups: 12 on a high-fat diet and 12 on a control diet (called "chow").

First, let's load our data using `read.csv()`:

```R
dat <- read.csv("femaleMiceWeights.csv")
```

You can view the entire dataset using the `View()` command:

```R
View(dat)
```

### Filtering Data with `filter()`

Suppose you want to work only with the mice on the "chow" diet. The **`filter()`** command allows you to select specific rows based on a condition.

To create a new dataset containing only the control mice (on the "chow" diet), you'd use:

```R
controls <- filter(dat, Diet == "chow")
```

In this command:
* `controls` is the new dataset where the filtered data will be stored.
* `filter()` is the function.
* `dat` is the original dataset you're filtering.
* `Diet == "chow"` is the condition: it tells R to keep only rows where the `diet` column is exactly "chow".

If you then `View(controls)`, you'll see only the rows corresponding to the chow diet.

### Selecting Columns with `select()`

Once you've filtered your data, you might only need specific columns. The **`select()`** command allows you to choose columns (or variables) from your dataset.

To obtain just the `bodyweight` column from your `controls` dataset:

```R
bodyweights_only <- select(controls, Bodyweight)
```

This will create a new data frame, `bodyweights_only`, containing only the `Bodyweight` column for the control mice.

### Converting to a Numeric Vector with `unlist()`

Many R functions work best with simple numeric vectors rather than data frames. You can convert a single-column data frame into a numeric vector using the **`unlist()`** command.

To convert `bodyweights_only` into a numeric vector:

```R
controls_vector <- unlist(bodyweights_only)
```

Now, `controls_vector` is a simple numeric vector of body weights, ready for further calculations like finding the mean. For example, `mean(controls_vector)` will give you the average body weight for the control mice.

## Chaining Commands with the Pipe (`%>%`)

One of `dplyr`'s most powerful features is the **pipe operator (`%>%`)**. The pipe allows you to chain multiple commands together in a readable and intuitive way, where the output of one command becomes the input for the next. This avoids creating many intermediate variables and makes your code more concise and easier to follow.

Instead of writing separate lines for `filter()`, `select()`, and `unlist()`, you can combine them using pipes:

```R
controls_filtered_data <- dat %>%
  filter(Diet == "chow") %>%
  select(Bodyweight) %>%
  unlist()
```

Let's break down this pipe:
* `dat %>%`: Start with the `dat` dataset and "pipe" it to the next function.
* `filter(diet == "chow") %>%`: The result of the previous step (which is `dat`) is filtered where `diet` equals "chow", and then this result is piped to the next function.
* `select(bodyweight) %>%`: The filtered data is then used by `select()` to pick the `bodyweight` column, and this result is piped again.
* `unlist()`: Finally, the selected `bodyweight` column (which is now a single-column data frame) is converted into a numeric vector.

This single, chained command accomplishes the same task as the three separate commands shown earlier, but in a much more fluid and readable manner. When you run this line, `controls_filtered_data` will contain the same numeric vector of bodyweights for the control mice.

For instance, you could then calculate the mean:

```R
mean(controls_filtered_data)
# Output: 23.8133
```

This brief introduction covers the core `dplyr` commands: `filter()`, `select()`, and the powerful pipe (`%>%`) operator. You'll be using these frequently throughout the course for various data manipulation tasks.

---

#### `code.R`

Script file from this lesson.

```R
dat <- read.csv("femaleMiceWeights.csv")
library(dplyr)

controls <- filter(dat, Diet=="chow")
controls <- select(controls, Bodyweight)
unlist(controls)

controls <- filter(dat, Diet=="chow") %>%
  select(Bodyweight) %>%
  unlist()

mean(controls)
```
