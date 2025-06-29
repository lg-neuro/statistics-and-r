---
layout: page
title: Importing Data into R
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

# Importing Data into R

## [Genomics Class](https://www.github/genomicsclass/)

Throughout this course, we're going to be using a web service called **GitHub**. You can get to our GitHub page by typing https://www.github/genomicsclass/. It includes links to several different repositories that we use throughout the course and the series.

Two specific repositories are fundamental. One is the `labs` repository: it includes the code that we use in the videos. When you watch videos, we'll provide a link to the specific code or script that you can use to follow along on the video. And the other is the `dagdata` repository that includes data sets that we use in class.

Yiu can download data by simply following links here. `dagdata` is actually an R package that you can install, but we're not necessarily going to do that during the first course.

### How to download raw data from GitHub

Go to `/dagdata/inst/extdata/`: here you can see links to csv files and text files. These are small data sets that we deliver as a file, and for the first few videos will use mostly the mice data in these files.

To download them you can click on one of these, for example `femalesMiceWeights`, and you can see the data is put in a nice little table. Now, we do not want to download the table as is rather we want the CSV (Comma-Separated Value) version of the table. To get it click on `Raw` and go to `File` menu in the top bar of your browser and save it as "source" (not "web archive") in the folder you want. Be careful to save it just with the `.csv` extention.

Now, there are other ways to download files and these aree well explained in the [By the book](#by-the-book) section.

## By the book

The first step when preparing to analyze data is to read in the data into R. There are several ways to do this and we will discuss three of them. But you only need to learn one to follow along. 

In the life sciences, small datasets such as the one used as an example in the next sections are typically stored as Excel files. Although there are R packages designed to read Excel (xls) format, you generally want to avoid this and save files as comma delimited (Comma-Separated Value/CSV) or tab delimited (Tab-Separated Value/TSV/TXT) files. These plain-text formats are often easier for sharing data with collaborators, as commercial software is not required for viewing or working with the data.

We will start with a simple example dataset containing [female mouse weights](https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/femaleMiceWeights.csv).

The first step is to find the file containing your data and know its *path*. 

### Paths and the Working Directory

When you are working in R it is useful to know your _working directory_. This is the directory or folder in which R will save or look for files by default. You can see your working directory by typing:

```{r, eval=FALSE}
getwd()
```

You can also change your working directory using the function `setwd`. Or you can change it through RStudio by clicking on "Session". 

The functions that read and write files (there are several in R) assume you mean to look for files or write files in the working directory. Our recommended approach for beginners will have you reading and writing to the working directory. However, you can also type the [full path](http://www.computerhope.com/jargon/a/absopath.htm), which will work independently of the working directory.

### Projects in RStudio

We find that the simplest way to organize yourself is to start a Project in RStudio (Click on "File" and "New Project"). When creating the project, you will select a folder to be associated with it. You can then download all your data into this folder. Your working directory will be this folder.

### Option 1: Read file over the Internet
You can navigate to the `femaleMiceWeights.csv` file by visiting the
data directory of dagdata on
[GitHub](https://github.com/genomicsclass/dagdata/tree/master/inst/extdata). If you navigate to the file, you need to click on *Raw* on the
upper right hand corner of the page. 

Now you can copy and paste the URL and use this as the argument to `read.csv`.
Here we break the URL into a base directory and a filename and then combine
with `paste0` because the URL would otherwise be too long for the page.
We use `paste0` because we want to put the strings together as is, if you were
specifying a file on your machine you should use the smarter function, `file.path`,
which knows the difference between Windows and Mac file path connectors.
You can specify the URL using a single string to avoid this extra step.

```{r,message=FALSE}
dir <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/"
url <- paste0(dir, "femaleMiceWeights.csv")
dat <- read.csv(url)
```

### Option 2: Download file with your browser to your working directory

There are reasons for wanting to keep a local copy of the file. For example, you may want to run the analysis while not connected to the Internet or you may want to ensure reproducibility regardless of the file being available on the original site. To download the file, as in option 1, you can navigate to the `femaleMiceWeights.csv`. In this option we use your browser's "Save
As" function to ensure that the downloaded file is in a CSV
format. Some browsers add an extra suffix to your filename by
default. You do not want this. You want your file to be named
`femaleMiceWeights.csv`. Once you have this file in your working directory, then you can simply read it in like this:

```{r,eval=FALSE}
dat <- read.csv("femaleMiceWeights.csv")
```

If you did not receive any message, then you probably read in the file successfully.

### Option 3: Download the file from within R

We store many of the datasets used here on [GitHub](https://github.com/genomicsclass/). You can save these files directly from the Internet to your computer using R. In this example, we are using the `download.file` function in the `downloader` package to download the file to a specific location and then read it in. We can assign it a random name and a random directory using the function `tempfile`, but you can also save it in directory with the name of your choosing.

```{r,message=FALSE}
library(downloader) ##use install.packages to install
dir <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/"
filename <- "femaleMiceWeights.csv" 
url <- paste0(dir, filename)
if (!file.exists(filename)) download(url, destfile=filename)
```

We can then proceed as in option 2:
```{r}
dat <- read.csv(filename)
```

### Option 4: Download the data package (Advanced)

Many of the datasets we include in this book are available in custom-built packages from GitHub. The reason we use GitHub, rather than CRAN, is that on GitHub we do not have to vet packages, which gives us much more flexibility. 

To install packages from GitHub you will need to install the `devtools` package:

```{r,eval=FALSE}
install.packages("devtools")
```

Note to Windows users: to use devtools you will have to also install `Rtools`. In general you will need to install packages as administrator. One way to do this is to start R as administrator. If you do not have permission to do this, then it is a bit [more complicated](http://www.magesblog.com/2012/04/installing-r-packages-without-admin.html). 

Now you are ready to install a package from GitHub. For this we use a different function:

```{r,message=FALSE,eval=FALSE}
library(devtools)
install_github("genomicsclass/dagdata")
```

The file we are working with is actually included in this package. Once you install the package, the file is on your computer. However, finding it requires advanced knowledge. Here are the lines of code:

```{r}
dir <- system.file(package="dagdata") #extracts the location of package
list.files(dir)
list.files(file.path(dir,"extdata")) #external data is in this directory
```

And now we are ready to read in the file:

```{r}
filename <- file.path(dir,"extdata/femaleMiceWeights.csv")
dat <- read.csv(filename)
```