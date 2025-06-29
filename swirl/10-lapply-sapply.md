# `lapply()` and `sapply()`

In this lesson, you'll learn how to use `lapply()` and `sapply()`, the two most important members of R's *apply family of functions, also known as loop functions.

These powerful functions, along with their close relatives (`vapply()` and `tapply()`, among others) offer a concise and convenient means of implementing the Split-Apply-Combine strategy for data analysis.

Each of the *apply functions will SPLIT up some data into smaller pieces, APPLY a function to each piece, then COMBINE the results. A more detailed discussion of this strategy is found in Hadley Wickham's Journal of Statistical Software paper titled 'The Split-Apply-Combine Strategy for Data Analysis'.

Throughout this lesson, we'll use the Flags dataset from the UCI Machine Learning Repository. This dataset contains details of various nations and their flags. More information may be found here: http://archive.ics.uci.edu/ml/datasets/Flags

## Exploring the Dataset

I've stored the dataset in a variable called `flags`. Type `head(flags)` to preview the first six lines (i.e. the 'head') of the dataset.

```R
> head(flags)
            name landmass zone area population language religion bars stripes colours red green blue gold white black orange mainhue circles crosses saltires quarters sunstars crescent triangle icon animate text topleft botright

1    Afghanistan        5    1  648         16       10        2    0       3       5   1     1    0    1     1     1      0   green       0       0        0        0        1        1        0        0    1       0    0   black    green
2        Albania        3    1   29          3        6        6    0       0       3   1     0    0    1     0     1      0     red       0       0        0        0        1        2        0        0    0       1    0     red      red
3        Algeria        4    1 2388         20        8        2    2       0       3   1     1    0    0     1     0      0   green       0       0        0        0        1        3        1        0    0       0    0   green    white
4 American-Samoa        6    3    0          0        1        1    0       0       5   1     0    1    1     1     0      1    blue       0       0        0        0        0        4        0        1    1       1    0    blue      red
5        Andorra        3    1    0          0        6        0    3       0       3   1     0    1    1     0     0      0    gold       0       0        0        0        0        5        0        0    0       0    0    blue      red
6         Angola        4    2 1247          7       10        5    0       2       3   1     0    0    1     0     1      0     red       0       0        0        0        1        6        0        0    1       0    0     red    black
```

You may need to scroll up to see all of the output. Now, let's check out the dimensions of the dataset using `dim(flags)`.

```R
> dim(flags)
[1] 194  30
```

This tells us that there are $194$ rows, or observations, and $30$ columns, or variables. Each observation is a country and each variable describes some characteristic of that country or its flag. To open a more complete description of the dataset in a separate text file, type `viewinfo()` when you are back at the prompt (`>`).

### Understanding Data Classes

As with any dataset, we'd like to know in what format the variables have been stored. In other words, what is the 'class' of each variable? What happens if we do `class(flags)`? Try it out.

```R
> class(flags)
[1] "data.frame"
```

That just tells us that the entire dataset is stored as a 'data.frame', which doesn't answer our question. What we really need is to call the `class()` function on each individual column. While we could do this manually (i.e. one column at a time) it's much faster if we can automate the process. Sounds like a loop!

## The lapply() Function

The `lapply()` function takes a list as input, applies a function to each element of the list, then returns a list of the same length as the original one. Since a data frame is really just a list of vectors (you can see this with `as.list(flags)`), we can use `lapply()` to apply the `class()` function to each column of the flags dataset. Let's see it in action!

Type `cls_list <- lapply(flags, class)` to apply the `class()` function to each column of the flags dataset and store the result in a variable called `cls_list`. Note that you just supply the name of the function you want to apply (i.e. class), without the usual parentheses after it.

```R
> cls_list <- lapply(flags, class)
```

Type `cls_list` to view the result.

```R
> cls_list
$name
[1] "character"

$landmass
[1] "integer"

$zone
[1] "integer"
...
```

The `l` in `lapply` stands for *'list'*. Type `class(cls_list)` to confirm that `lapply()` returned a list.

```R
> class(cls_list)
[1] "list"
```

As expected, we got a list of length $30$ -- one element for each variable/column. The output would be considerably more compact if we could represent it as a vector instead of a list.

You may remember from a previous lesson that lists are most helpful for storing multiple classes of data. In this case, since every element of the list returned by `lapply()` is a character vector of length one (i.e. "integer" and "vector"), `cls_list` can be simplified to a character vector. To do this manually, type `as.character(cls_list)`.

```R
> as.character(cls_list)
 [1] "character" "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "character" "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "integer"   "character" "character"
```

## The sapply() Function

`sapply()` allows you to automate this process by calling `lapply()` behind the scenes, but then attempting to simplify (hence the `s` in `sapply`) the result for you. Use `sapply()` the same way you used `lapply()` to get the class of each column of the flags dataset and store the result in `cls_vect`.

```R
> cls_vect <- sapply(flags, class)
```

Use `class(cls_vect)` to confirm that `sapply()` simplified the result to a character vector.

```R
> class(cls_vect)
[1] "character"
```

In general, if the result is a list where every element is of length one, then `sapply()` returns a vector. If the result is a list where every element is a vector of the same length ($> 1$), `sapply()` returns a matrix. If `sapply()` can't figure things out, then it just returns a list, no different from what `lapply()` would give you.

#### Practical Examples with Color Data

Let's practice using `lapply()` and `sapply()` some more!

Columns $11$ through $17$ of our dataset are indicator variables, each representing a different color. The value of the indicator variable is $1$ if the color is present in a country's flag and $0$ otherwise.

Therefore, if we want to know the total number of countries (in our dataset) with, for example, the color orange on their flag, we can just add up all of the $1$s and $0$s in the 'orange' column. Try `sum(flags$orange)` to see this.

```R
> sum(flags$orange)
[1] 26
```

Now we want to repeat this operation for each of the colors recorded in the dataset.

First, use `flag_colors <- flags[, 11:17]` to extract the columns containing the color data and store them in a new data frame called `flag_colors`. (Note the comma before $11:17$. This subsetting command tells R that we want all rows, but only columns $11$ through $17$.)

```R
> flag_colors <- flags[, 11:17]
```

Use the `head()` function to look at the first $6$ lines of `flag_colors`.

```R
> head(flag_colors)
  red green blue gold white black orange
1   1     1    0    1     1     1      0
2   1     0    0    1     0     1      0
3   1     1    0    0     1     0      0
4   1     0    1    1     1     0      1
5   1     0    1    1     0     0      0
6   1     0    0    1     0     1      0
```

### Using `lapply()` with `sum()`

To get a list containing the sum of each column of `flag_colors`, call the `lapply()` function with two arguments. The first argument is the object over which we are looping (i.e. `flag_colors`) and the second argument is the name of the function we wish to apply to each column (i.e. `sum`). Remember that the second argument is just the name of the function with no parentheses, etc.

```R
> lapply(flag_colors, sum)
$red
[1] 153

$green
[1] 91

$blue
[1] 99

$gold
[1] 91

$white
[1] 146

$black
[1] 52

$orange
[1] 26
```

This tells us that of the $194$ flags in our dataset, $153$ contain the color red, $91$ contain green, $99$ contain blue, and so on.

The result is a list, since `lapply()` always returns a list. Each element of this list is of length one, so the result can be simplified to a vector by calling `sapply()` instead of `lapply()`. Try it now.

```R
> sapply(flag_colors, sum)
   red  green   blue   gold  white  black orange 
   153     91     99     91    146     52     26
```

### Using `sapply()` with `mean()`

Perhaps it's more informative to find the proportion of flags (out of $194$) containing each color. Since each column is just a bunch of $1$s and $0$s, the arithmetic mean of each column will give us the proportion of $1$s. (If it's not clear why, think of a simpler situation where you have three $1$s and two $0$s -- $(1 + 1 + 1 + 0 + 0)/5 = 3/5 = 0.6$).

Use `sapply()` to apply the `mean()` function to each column of `flag_colors`. Remember that the second argument to `sapply()` should just specify the name of the function (i.e. `mean`) that you want to apply.

```R
> sapply(flag_colors, mean)
      red     green      blue      gold     white     black    orange 
0.7886598 0.4690722 0.5103093 0.4690722 0.7525773 0.2680412 0.1340206
```

### `sapply()` Returning a Matrix

In the examples we've looked at so far, `sapply()` has been able to simplify the result to vector. That's because each element of the list returned by `lapply()` was a vector of length one. Recall that `sapply()` instead returns a matrix when each element of the list returned by `lapply()` is a vector of the same length (> 1).

To illustrate this, let's extract columns $19$ through $23$ from the flags dataset and store the result in a new data frame called `flag_shapes`.

```R
> flag_shapes <- flags[, 19:23]
```

Each of these columns (i.e. variables) represents the number of times a particular shape or design appears on a country's flag. We are interested in the minimum and maximum number of times each shape or design appears.

The `range()` function returns the minimum and maximum of its first argument, which should be a numeric vector. Use `lapply()` to apply the range function to each column of `flag_shapes`. Don't worry about storing the result in a new variable. By now, we know that `lapply()` always returns a list.

```R
> lapply(flag_shapes, range)
$circles
[1] 0 4

$crosses
[1] 0 2

$saltires
[1] 0 1

$quarters
[1] 0 4

$sunstars
[1]  0 50
```

Do the same operation, but using `sapply()` and store the result in a variable called `shape_mat`.

```R
> shape_mat <- sapply(flag_shapes, range)
```

View the contents of `shape_mat`.

```R
> shape_mat
     circles crosses saltires quarters sunstars
[1,]       0       0        0        0        0
[2,]       4       2        1        4       50
```

Each column of `shape_mat` gives the minimum (row $1$) and maximum (row $2$) number of times its respective shape appears in different flags.

Use the `class()` function to confirm that `shape_mat` is a matrix.

```R
> class(shape_mat)
[1] "matrix" "array"
```

### `sapply()` Cannot Always Simplify

As we've seen, `sapply()` always attempts to simplify the result given by `lapply()`. It has been successful in doing so for each of the examples we've looked at so far. Let's look at an example where `sapply()` can't figure out how to simplify the result and thus returns a list, no different from `lapply()`.

When given a vector, the `unique()` function returns a vector with all duplicate elements removed. In other words, `unique()` returns a vector of only the 'unique' elements. To see how it works, try `unique(c(3, 4, 5, 5, 5, 6, 6))`.

```R
> unique(c(3,4,5,5,5,6,6))
[1] 3 4 5 6
```

We want to know the unique values for each variable in the flags dataset. To accomplish this, use `lapply()` to apply the `unique()` function to each column in the flags dataset, storing the result in a variable called `unique_vals`.

```R
> unique_vals <- lapply(flags, unique)
```

Print the value of `unique_vals` to the console.

```R
> lapply(flags, unique)
$name
  [1] "Afghanistan"              "Albania"                  "Algeria"                  "American-Samoa"           "Andorra"                  "Angola"                   "Anguilla"                 "Antigua-Barbuda"          "Argentina"                "Argentine"                "Australia"                "Austria"                  "Bahamas"                  "Bahrain"                  "Bangladesh"               "Barbados"                 "Belgium"                  "Belize"                   "Benin"                    "Bermuda"                  "Bhutan"                   "Bolivia"                  "Botswana"                 "Brazil"                   "British-Virgin-Isles"     "Brunei"                   "Bulgaria"                 "Burkina"                  "Burma"                    "Burundi"                  "Cameroon"                 "Canada"                   "Cape-Verde-Islands"       "Cayman-Islands"           "Central-African-Republic" "Chad"                     "Chile"                    "China"                    "Colombia"                 "Comorro-Islands"          "Congo"                    "Cook-Islands"             "Costa-Rica"               "Cuba"                     "Cyprus"                   "Czechoslovakia"           "Denmark"                  "Djibouti"                 "Dominica"                 "Dominican-Republic"       "Ecuador"                  "Egypt"                    "El-Salvador"              "Equatorial-Guinea"        "Ethiopia"                 "Faeroes"                  "Falklands-Malvinas"       "Fiji"                     "Finland"                  "France"                   "French-Guiana"            "French-Polynesia"         "Gabon"                    "Gambia"                   "Germany-DDR"              "Germany-FRG"              "Ghana"                    "Gibraltar"                "Greece"                   "Greenland"                "Grenada"                  "Guam"                     "Guatemala"                "Guinea"                   "Guinea-Bissau"            "Guyana"                   "Haiti"                    "Honduras"                 "Hong-Kong"                "Hungary"                  "Iceland"                  "India"                    "Indonesia"                "Iran"                     "Iraq"                     "Ireland"                  "Israel"                   "Italy"                    "Ivory-Coast"              "Jamaica"                  "Japan"                    "Jordan"                   "Kampuchea"                "Kenya"                    "Kiribati"                 "Kuwait"                   "Laos"                     "Lebanon"                  "Lesotho"                  "Liberia"                  "Libya"                    "Liechtenstein"            "Luxembourg"               "Malagasy"                 "Malawi"                   "Malaysia"                 "Maldive-Islands"          "Mali"                     "Malta"                    "Marianas"                 "Mauritania"               "Mauritius"                "Mexico"                   "Micronesia"               "Monaco"                   "Mongolia"                 "Montserrat"               "Morocco"                  "Mozambique"               "Nauru"                    "Nepal"                    "Netherlands"              "Netherlands-Antilles"     "New-Zealand"              "Nicaragua"                "Niger"                    "Nigeria"                  "Niue"                     "North-Korea"              "North-Yemen"              "Norway"                   "Oman"                     "Pakistan"                 "Panama"                   "Papua-New-Guinea"         "Parguay"                  "Peru"                     "Philippines"              "Poland"                   "Portugal"                 "Puerto-Rico"              "Qatar"                    "Romania"                  "Rwanda"                   "San-Marino"               "Sao-Tome"                 "Saudi-Arabia"             "Senegal"                  "Seychelles"               "Sierra-Leone"             "Singapore"                "Soloman-Islands"          "Somalia"                  "South-Africa"             "South-Korea"              "South-Yemen"              "Spain"                    "Sri-Lanka"                "St-Helena"                "St-Kitts-Nevis"           "St-Lucia"                 "St-Vincent"               "Sudan"                    "Surinam"                  "Swaziland"                "Sweden"                   "Switzerland"              "Syria"                    "Taiwan"                   "Tanzania"                 "Thailand"                 "Togo"                     "Tonga"                    "Trinidad-Tobago"          "Tunisia"                  "Turkey"                   "Turks-Cocos-Islands"      "Tuvalu"                   "UAE"                      "Uganda"                   "UK"                       "Uruguay"                  "US-Virgin-Isles"          "USA"                      "USSR"                     "Vanuatu"                  "Vatican-City"             "Venezuela"                "Vietnam"                  "Western-Samoa"            "Yugoslavia"               "Zaire"                    "Zambia"                   "Zimbabwe"                

$landmass
[1] 5 3 4 6 1 2

$zone
[1] 1 3 2 4
...                              
```

Since `unique_vals` is a list, you can use what you've learned to determine the length of each element of `unique_vals` (i.e. the number of unique values for each variable). Simplify the result, if possible. Hint: Apply the `length()` function to each element of `unique_vals`.

```R
> sapply(unique_vals, length)
      name   landmass       zone       area population   language   religion       bars    stripes    colours        red      green       blue       gold      white      black    orange    mainhue    circles    crosses   saltires   quarters   sunstars   crescent   triangle       icon    animate       text    topleft   botright  
       194          6          4        136         48         10          8          5         12          8          2          2          2          2          2          2         2          8          4          3          2          3         14          2          2          2          2          2          7          8
```

The fact that the elements of the `unique_vals` list are all vectors of *different* length poses a problem for `sapply()`, since there's no obvious way of simplifying the result.

Use `sapply()` to apply the `unique()` function to each column of the flags dataset to see that you get the same unsimplified list that you got from `lapply()`.

```R
> sapply(flags, unique)
$name
  [1] "Afghanistan"              "Albania"                  "Algeria"                  "American-Samoa"           "Andorra"                  "Angola"                   "Anguilla"                 "Antigua-Barbuda"          "Argentina"                "Argentine"                "Australia"                "Austria"                  "Bahamas"                  "Bahrain"                  "Bangladesh"               "Barbados"                 "Belgium"                  "Belize"                   "Benin"                    "Bermuda"                  "Bhutan"                   "Bolivia"                  "Botswana"                 "Brazil"                   "British-Virgin-Isles"     "Brunei"                   "Bulgaria"                 "Burkina"                  "Burma"                    "Burundi"                  "Cameroon"                 "Canada"                   "Cape-Verde-Islands"       "Cayman-Islands"           "Central-African-Republic" "Chad"                     "Chile"                    "China"                    "Colombia"                 "Comorro-Islands"          "Congo"                    "Cook-Islands"             "Costa-Rica"               "Cuba"                     "Cyprus"                   "Czechoslovakia"           "Denmark"                  "Djibouti"                 "Dominica"                 "Dominican-Republic"       "Ecuador"                  "Egypt"                    "El-Salvador"              "Equatorial-Guinea"        "Ethiopia"                 "Faeroes"                  "Falklands-Malvinas"       "Fiji"                     "Finland"                  "France"                   "French-Guiana"            "French-Polynesia"         "Gabon"                    "Gambia"                   "Germany-DDR"              "Germany-FRG"              "Ghana"                    "Gibraltar"                "Greece"                   "Greenland"                "Grenada"                  "Guam"                     "Guatemala"                "Guinea"                   "Guinea-Bissau"            "Guyana"                   "Haiti"                    "Honduras"                 "Hong-Kong"                "Hungary"                  "Iceland"                  "India"                    "Indonesia"                "Iran"                     "Iraq"                     "Ireland"                  "Israel"                   "Italy"                    "Ivory-Coast"              "Jamaica"                  "Japan"                    "Jordan"                   "Kampuchea"                "Kenya"                    "Kiribati"                 "Kuwait"                   "Laos"                     "Lebanon"                  "Lesotho"                  "Liberia"                  "Libya"                    "Liechtenstein"            "Luxembourg"               "Malagasy"                 "Malawi"                   "Malaysia"                 "Maldive-Islands"          "Mali"                     "Malta"                    "Marianas"                 "Mauritania"               "Mauritius"                "Mexico"                   "Micronesia"               "Monaco"                   "Mongolia"                 "Montserrat"               "Morocco"                  "Mozambique"               "Nauru"                    "Nepal"                    "Netherlands"              "Netherlands-Antilles"     "New-Zealand"              "Nicaragua"                "Niger"                    "Nigeria"                  "Niue"                     "North-Korea"              "North-Yemen"              "Norway"                   "Oman"                     "Pakistan"                 "Panama"                   "Papua-New-Guinea"         "Parguay"                  "Peru"                     "Philippines"              "Poland"                   "Portugal"                 "Puerto-Rico"              "Qatar"                    "Romania"                  "Rwanda"                   "San-Marino"               "Sao-Tome"                 "Saudi-Arabia"             "Senegal"                  "Seychelles"               "Sierra-Leone"             "Singapore"                "Soloman-Islands"          "Somalia"                  "South-Africa"             "South-Korea"              "South-Yemen"              "Spain"                    "Sri-Lanka"                "St-Helena"                "St-Kitts-Nevis"           "St-Lucia"                 "St-Vincent"               "Sudan"                    "Surinam"                  "Swaziland"                "Sweden"                   "Switzerland"              "Syria"                    "Taiwan"                   "Tanzania"                 "Thailand"                 "Togo"                     "Tonga"                    "Trinidad-Tobago"          "Tunisia"                  "Turkey"                   "Turks-Cocos-Islands"      "Tuvalu"                   "UAE"                      "Uganda"                   "UK"                       "Uruguay"                  "US-Virgin-Isles"          "USA"                      "USSR"                     "Vanuatu"                  "Vatican-City"             "Venezuela"                "Vietnam"                  "Western-Samoa"            "Yugoslavia"               "Zaire"                    "Zambia"                   "Zimbabwe"                

$landmass
[1] 5 3 4 6 1 2

$zone
[1] 1 3 2 4
...                              
```

## Anonymous Functions

Occasionally, you may need to apply a function that is not yet defined, thus requiring you to write your own. Writing functions in R is beyond the scope of this lesson, but let's look at a quick example of how you might do so in the context of loop functions.

Pretend you are interested in only the second item from each element of the `unique_vals` list that you just created. Since each element of the `unique_vals` list is a vector and we're not aware of any built-in function in R that returns the second element of a vector, we will construct our own function.

`lapply(unique_vals, function(elem) elem[2])` will return a list containing the second item from each element of the `unique_vals` list. Note that our function takes one argument, `elem`, which is just a 'dummy variable' that takes on the value of each element of `unique_vals`, in turn.

```R
> lapply(unique_vals, function(elem) elem[2])
$name
[1] "Albania"

$landmass
[1] 3

$zone
[1] 3
...
```

The only difference between previous examples and this one is that we are defining and using our own function right in the call to `lapply()`. Our function has no name and disappears as soon as `lapply()` is done using it. So-called 'anonymous functions' can be very useful when one of R's built-in functions isn't an option.

In this lesson, you learned how to use the powerful `lapply()` and `sapply()` functions to apply an operation over the elements of a list. In the next lesson, we'll take a look at some close relatives of `lapply()` and `sapply()`.