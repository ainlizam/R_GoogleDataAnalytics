#R is case sensitive
#Here's an example of variable with data type 

first_variable <- "This is my variable" #text
second_variable <- 12.5                 #numeric assign value to variable

#vector - a group of data elements of the same type stored in a sequence in R
vec_1 <- c(13, 48.5, 71, 101.5, 2)
vec_1
#Atomic Vectors - Logical, Integer, Double , Character

#Pipes - expressing a sequence of multiple operations, represented with "%<%"
---------------------------------------------------------------------------------------

#CREATING VECTORS by call c() function means "combined". difference approach for each data type
#numeric data in a vector
c(2.5, 48.5, 101.5)
#integer data in a vector
c(1L, 5L, 15L)
#Character data in a vector
c("Ain" , "Ayuni", "Muiz", "Wafi")
#Logical data in a vector
c(TRUE, FALSE, TRUE, FALSE)

#Determining the properties of vectors
typeof(c(1L, 3L))

#Determining the length
x <- c(33.5, 57.75, 120.05)
length(x)

#Check specific type by using is function
x <- c(2L, 5L, 11L)
is.integer(x)          #change according to data type

#Naming Vector
x <- c(1,3,5)
x
names(x) <- c("a", "b", "c")
x 
------------------------------------------------------------------------------------
#Creating LIsts - different from Atomic Vectors coz their elements can be any type
list("a", 1L, 1.5, TRUE)

# Determining structure of lists
str(list("a", 1L, 1.5, TRUE))

z <- list(list(list(1 , 3, 5)))
str(z)

#Naming List
list('Chicago' = 1, 'New York' = 2, 'Los Angeles' = 3)
#$`Chicago`  boleh tukar2 nama dlm list

-------------------------------------------------------------------------------------
#DATES AND TIMES IN R
install.packages("tidyverse") 
library(tidyverse)
library(lubridate)

#Types

#("2016-08-16") - date
#(“20:11:59 UTC") - time within a day
#"2018-03-31 18:15:48 UTC") - date and time
  
today()
now()

#Converting from strings - year, month, day
ymd("2021-01-20")
mdy("January 20th, 2021")
dmy("20-Jan-2021")
ymd(20210120)

#Creating date-time components
ymd_hms("2021-01-20 20:11:59")
mdy_hm("01/20/2021 08:01")

#Switching between existing date-time objects
as_date(now())

--------------------------------------------------------------
#OTHER COMMON DATA STRUCTURE
#Data structure bring data elements together in a structured way
#Data Frame is a collection of columns containing data.
  
#Create Data Frame
data.frame(x = c(1, 2, 3) , y = c(1.5, 5.5, 7.5))
data.frame()
z <- data.frame(x = c(1, 2, 3) , y = c(1.5, 5.5, 7.5))
z[2,1]

#Matrices
matrix(c(3:8), nrow = 2)
matrix(c(3:8), ncol = 2)
----------------------------------------------------------------
#Our first calculation
quarter_1_sales <- 35657.98
quarter_2_sales <- 43810.55
midyear_sales <- quarter_1_sales + quarter_2_sales
yearend_sales <- midyear_sales * 2
--------------------------------------------------------------
#To Explore Package
installed.packages()
library(class)
browseVignettes("dplyr") #provide guides and example of using specific package
--------------------------------------------------------------------------------------
#Explore tidyverse
  #ggplot2 - data visualization
install.packages("palmerpenguins")
library("palmerpenguins")
library("ggplot2")

ggplot(data = penguins, aes (x=flipper_length_mm, y=body_mass_g)) + geom_point()
ggplot()
  
  #tidyr - data tidying and clean - data cleaning to make tidy data in the right type in the right place
  #dplyr - data manipulation - offers consistent set of function that help you complete some common data manipulation tasks
  #readr - use for importing data - read_csv

#Visualizing data with ggplot2
  #examine dataframe
  data(penguins)
  View(penguins)
  
  #visualize data
  ggplot(data=penguins) + #scatter plot
    geom_point(mapping = aes(x=flipper_length_mm, y=body_mass_g)) #geom = points, bar, line | aes - aesthetic
  
  ggplot(data=penguins) + 
    geom_point(mapping = aes(x=bill_length_mm, y=bill_depth_mm)) 
  
#Annotations and Labels
  ggplot(data=penguins)+
    geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g, color=species))+
    labs(title="Palmer Penguins: BodyMass vs. Flipper Length")
  
  ggplot(data=penguins)+
    geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g, color=species))+
    labs(title="Palmer Penguins: BodyMass vs. Flipper Length", subtitle="Sample of Three Penguin Species",
         caption="Data collected by Dr. Kristen Gorman") +
    annotate("text", x=220, y=3500, label="The Gentoos are the largest", color="purple",
             fontface="bold", size=4.5, angle=25)
  
  p <- ggplot(data=penguins)+
    geom_point(mapping=aes(x=flipper_length_mm, y=body_mass_g, color=species))+
    labs(title="Palmer Penguins: BodyMass vs. Flipper Length", subtitle="Sample of Three Penguin Species",
         caption="Data collected by Dr. Kristen Gorman") 

  p + annotate("text", x=220, y=3500, label="The Gentoos are the largest")
  
  #To save the plot
  ggsave("Three Penguin Species.png")
--------------------------------------------------------------------------------------
# Same data, different outcome
  install.packages("Tmisc")
  library(Tmisc)    #turner miscellaneous
  data(quartet)
  View(quartet)
  
  #Pipe 
  library(dplyr)
  quartet %>% 
    group_by (set) %>% 
    summarize(mean(x), sd(x), mean(y), sd(y), cor(x, y)) #cor is correlation between variables
  
  #Plot graph
  library(ggplot2)
  ggplot(quartet, aes(x, y)) + geom_point() + geom_smooth(method=lm, se=FALSE) + facet_wrap(~set)

  install.packages('datasauRus')
  library('datasauRus')    #datasets about dinasour
  data('datasauRus')
  View('datasauRus')
  
  ggplot(datasaurus_dozen, aes(x=x,y=y,colour=dataset)) + geom_point() + theme_void() + theme(legend.position = "none") + facet_wrap(~dataset, ncol=3)
  ----------------------------------------------------------------------------------------------------------------------------------------------------------------
# The bias function - unbiased is zero or closest the zero, far from zero is highly biased
  install.packages('SimDesign')
  library('SimDesign') #structure for organizing 
  
  actual_temp <- c(68.3, 70, 72.4, 71, 67, 70)
  predicted_temp <- c(67.9, 69, 71.5, 70, 67, 69)
  bias(actual_temp, predicted_temp) #bias function - 0.71 pretty close to zero , almost unbiased, actual outcome is larger than predicted outcome
  
  actual_sales <- c(150, 203, 137, 247, 116, 287)
  predicted_sales <- c(200, 300, 150, 250, 150, 300)
  bias (actual_sales, predicted_sales) #bias -35, pretty far from zero means the data is quite biased, predicted outcome is larger than actual outcome
  
# R Markdown
  install.packages('rmarkdown')
  