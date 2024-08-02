## Step 1: install package tidyverse
library(tidyverse) #contain sample datasets, `diamonds` dataset in the `ggplot2` package is a great example for previewing `R` functions. 

## Step 2: Viewing data
head(diamonds) #displays the columns and the first several rows of data
# `str()` and `glimpse()` functions will both return summaries of each column in your data arranged horizontally
str(diamonds) #structured
glimpse(diamonds) #summarize the data more neat
colnames(diamonds) #list of columns names from dataset

## Step 3: Cleaning data
rename(diamonds, carat_new = carat, cut_new = cut)
summarize(diamonds, mean_carat = mean(carat))

## Step 4: Visualizing data
ggplot(data = diamonds, aes(x = carat, y = price)) + geom_point ()
ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) + geom_point() #add color on the plot based on the cut categories
ggplot(data = diamonds, aes(x = carat, y = price, color = cut)) + geom_point() + facet_wrap(~cut)

## Step 5: Documentation

## Activity Wrap-up
# You have had a chance to explore more `R` tools that you can start using on your own. 
# You learned how to install and load `R packages`; functions for viewing, cleaning, and visualizing data; 
# and using `R markdown`to export your work. 
# Feel free to continue exploring these functions in the rmd file, or use this code in your own RStudio project space. 
# As you practice on your own, consider how `R` is similar and different from the tools you have already learned in this program, 
# and how you might start using it for your own data analysis projects. `R` provides a lot of flexibility and utility that can make it a key tool in a data analyst's tool kit. 
