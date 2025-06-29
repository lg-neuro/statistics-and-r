---
layout: page
title: RStudio for Organization
author: "Leonardo Genero - HarvardX PH525.1x: Statistics and R"
---

# Organizing Data and Code in RStudio

When you're analyzing data, it's crucial to stay organized with your code and data files. RStudio offers a straightforward way to manage this through **projects**, which streamline your workflow and keep everything in its place.

## Setting Up an RStudio Project

To begin, you'll create a new project in RStudio. Navigate to **File** then **New Project**. From there, select **New Directory**, followed by **Empty Project**. You'll then be prompted to give your project a name, such as `project1`, though you can choose any name you like. Finally, select the directory on your computer where you want this project folder to reside; your home directory is often a convenient starting point. Once created, RStudio will recognize this project file and its associated folder. Any files you save within this project will automatically be directed to its designated folder, and RStudio will prioritize searching within this folder when looking for data or scripts.

## Downloading Data for Your Project

For this lesson, you'll download example data from a **GitHub repository**.

* First, go to the `dagdata` repository on GitHub and follow the path to `inst` then `extdata`. Here, you'll find a list of data files, often in CSV format.
* To download a file, click on the desired one, for example, `femaleMiceWeights`.
* Then, click the **Raw** button to view the raw data.
* Right-click (or use `File` > `Save As` on most browsers) and choose **Save As...**.
* It's crucial to **save the file directly into your RStudio project folder**.
* Ensure the file is saved as a **CSV file** with the `.csv` extension. Be careful not to append a `.txt` extension if your browser suggests it; look for an option like "Don't Append." Once saved, the file will immediately appear in your RStudio project panel.
* Repeat this process for any other data files you need, such as additional mouse phenotype files.

## Creating and Saving R Scripts

Saving your R code in script files is a best practice for reproducibility and organization. To create a new R script, go to **File**, then **New File**, and select **R Script**. An empty script editor will open in the source panel.

You can then type your R commands, for instance, `2 + 2`. To save your script, use the keyboard shortcut (`Command-S` on Mac, `Ctrl-S` on Windows/Linux) or go to **File** then **Save**. It's a good idea to **name your script with a `.R` extension**, like `code.R`, as this helps RStudio recognize it as an R script. Save it within your project folder, and the script will then appear in your project panel. To run a line of code from your script, place your cursor on that line and use the keyboard shortcut (`Command-Enter` on Mac, `Ctrl-Enter` on Windows/Linux). The command will execute in the R console, and the output will be displayed there.

## Reading Data into R

One of the initial steps in data analysis is loading your data into R. For CSV files, the **`read.csv()`** function is essential. If you want to learn more about this function, simply type `?read.csv` in the console and press **Enter**; the help documentation will appear in the fourth RStudio panel.

To load your data, you'll assign the data to an R object within your script, for example, `dat`. Then, use `read.csv()` to load your file:

```R
dat <- read.csv("femaleMiceWeights.csv")
```

RStudio offers **auto-completion**, so you can start typing the filename and press **Tab** to see suggestions, which saves you from typing the full name. Execute this line of code using the keyboard shortcut. Once executed, your data will be loaded into the `dat` object in your R environment, ready for further analysis.

By following these steps, you've successfully established an RStudio project, downloaded necessary data, created and saved an R script, and loaded your data. This foundational setup provides a robust and organized environment for your data analysis endeavors.