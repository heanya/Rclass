########CLASS NOTES WEEK 3 9/13 edit########

# R update (to run in R native GUI only)
if(!require(installr)) {
  install.packages("installr"); require(installr)} 
updateR()

#functions
# install the package `abc` with its name
install.packages("abc")

###13.9.22 R Environment!
install.packages("abc")
library("abc")
install.packages('vegan')
library('vegan')
getwd()
setwd("/Users/Rod/R") #pa set it up se pone todo el nombre del folder!

# I create and list 3 objects 
a<-'corals' # create an object 'a' containing 'corals'
b<-'are' # create an object 'b' containing 'are'
c<-'cool'# create an object 'c' containing 'cool'
ls() # list objects 'a', 'b', 'c'

# clean objects in memory
rm(list=ls()) #or rm(THEOBJECTHERE!) and it will remove from your list

# 1. using the package `readxl`
# 2. reading my `reef_fish.xlsx` in my working directory
# 3. importing `reef_fish.xlsx` in a `fish` object
library(readxl) # load the package `readxl'
read_excel('reef_fish.xlsx') # automatically print on my screen

# importing a .txt file
fish<-read.table('reef_fish.txt', header=T, sep='\t', dec='.') 

#exiting R
q()

#simple plot from the file 'fish'
barplot(fish$richness, main="Top 10 reef fish Richness (Allen, 2000)", horiz=TRUE, names.arg=fish$country, cex.names=0.5, las=1)


###20.9.22 Manipulation
rm(list=ls()) # clean memory
library (datasets) # load package
data(iris) # import dataset
head (iris) # visualize 'head' dataset

str(iris) # examine the structure of the object

summary(iris) #  object summary -->to see if the data is balance or not!

fix(iris) # spreadsheet --> para corregir errores o typos en una spreadsheet

students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.') # read data set from url
str(students)
head(students)

#R syntaxt : dataset[no. row, no. column]
students[1,]

#subset
students$gender=="female" # condition
f<-students$gender=="female" # filter
females<-students[f,]
females
rownames(females)<-c("Vanessa", "Vicky","Michelle","Joyce","Victoria")
females
rownames(females)<-females$height #to use height as the rownames, when using big datasets!

setosa <-iris$Species=="setosa"
setosa <-iris[setosa,]
versi <-iris$Species=="versicolor"
versicolor <-iris[versi,]
virgi <-iris$Species=="virginica"
virginica <-iris[virgi,]


########CLASS NOTES WEEK 3 9/20########

#Data Manipulation
rm(list=ls()) # clean memory
library (datasets) # load package
data(iris) # import dataset
head (iris) # visualize 'head' dataset

#summarize dataset

summary(iris) #object summary
str(iris) #examine the structure of the object

#subset #practice 2.1
s<-iris$Species=="setosa"#S tiene que ser en mayuscula
versi<-iris$Species=="versicolor"
virgi<-iris$Species=="virginica"

#selection
setosa<-iris[s,]
versicolor<-iris[versi,]
virginica<-iris

#para ver la structure de tu subset
str(setosa)
str(versicolor)
str(virginica)

#Fix to correct mistake in your code
fix(iris) #spreadsheet

#sample
?sample #help to explain function

#sorting

indl<-order(iris$Species)

#recording
colors<-ifelse(students$gender=="male","blue","red")

students$color<-ifelse(students$gender=="male","blue","red")

students$gender<-ifelse(students$gender=="male","green","yellow")

tall<-students$height>=160
tall

#Practice 2.2 
#setosa=purple, versicolor=blue, virginica=pink 
?subset
iris
iris$color<-ifelse(iris$Species=="setosa","purple",ifelse(iris$Species=="virginica","pink", "blue"))
iris #you can write "ifelse" more than once if you want to rename more than 2 values 
indl<-order(iris$Sepal.Width)
iris.decreasing<-order(iris$Sepal.Width,decreasing=T)
small<-iris[iris.decreasing,]
filter<-small$Species=="versicolor"
filter
finalsmall<-small[filter,]
finalsmall

#delete color or column NULL
# way no 1
iris$color<-NULL 
iris

# way no 2
subset<-finalsmall[,1:5]
subset

########CLASS NOTES WEEK 3 9/27########
#package dplyr
install.packages("dplyr")
library(dplyr)
?dplyr


#summarize section
summarised <- summarise(iris, Mean.Width = mean(Sepal.Width))
head(summarised)
#NB. summarised is a more precise alternative to the 
#function summary discovered last


#manipulate section
#by col. name directly
selected1 <- dplyr::select(iris, Sepal.Length, Sepal.Width, Petal.Length)
head(selected1) 

#by col. range, especially useful when you have many to select
selected2 <- dplyr::select(iris, Sepal.Length:Petal.Length)
head(selected2, 4)

#by col. range number (similar with subset)
selected3 <- dplyr::select(iris,c(2:5))
head(selected3)

#Use - to hide a particular column
#Note the use of the notation :: 
#The use of :: is to call a function from a specific package without necessarily loading the package.
selected4 <- dplyr::select(iris, -Sepal.Length, -Sepal.Width)
head(selected4)

#filter

#last's week exercise for filtering
setosa<-iris
#new version for the same one
filtered1 <- filter(iris, Species == "setosa" )
head(filtered1,15)

filtered2<-filter(iris, Species=="versicolor", Sepal.Width>3)
head(filtered2)

#trick sponsored by Lauriane
tail(filtered2, 2)

#when you want very specific values is better to ue []
#you must know the total amount of your data set

filtered2[c(36:37),c(1,3)] 

#mutate
#The function mutate is to create new columns (variables) 
#while preserving existing columns in a data set.

mutated1 <- mutate(iris, Greater.Half = Sepal.Width > 0.5 * Sepal.Length)
tail(mutated1)

#to check the number of individuals 
#where condition is TRUE and FALSE

table(mutated1$Greater.Half)

iris$mutated1<-
  
  #arrange
  
  # Sepal Width by ascending order
  arranged1 <- arrange(iris, Sepal.Width)
head(arranged1)

tail(arranged1)
# Sepal Width by descending order
arranged2 <- arrange(iris, desc(Sepal.Width))
head(arranged2)

tail(arranged2)

#group_by

# Mean sepal width by Species
gp <- group_by(iris, Species)
gp.mean <- summarise(gp,Mean.Sepal = mean(Sepal.Width))
gp.mean

#Which produces a tibble 
#(a data frame with stricter checking and better formatting)

?tibble::tibble


#Pipe operator
# %>% allows to wrap multiple functions together
#pipe operator is becoming increasingly used in R.

#To select the rows with conditions
iris %>% filter(Species == "setosa",Sepal.Width > 3.8)

#To find mean SepalLength by Species:

iris  %>% group_by(Species) %>% summarise(Mean.Length = mean(Sepal.Length))

#To select the rows with conditions
iris %>% filter(Species == "setosa",Sepal.Width > 3.8)

#To find mean SepalLength by Species
iris  %>% group_by(Species) %>% summarise(Mean.Length = mean(Sepal.Length))


head(iris%>%arrange(iris,Sepal.Width)%>%filter(Species=="setosa", Sepal.Width>3.8))
tail(iris%>%arrange(iris,Sepal.Width)%>%filter(Species=="setosa", Sepal.Width>3.0))

#tidyr

rm(list=ls()) #clean memory
install.packages("tidyr")
library(tidyr)
?tidyr

#it has 5 main categories

#pivoting: extremely useful as ecological dataset anaylisis
#rectangling->
#nesting
#Splitting and combining
# implicit missing values 

#pivot section
getwd()
TW_corals<-read.table('tw_corals.txt', header=T, sep='\t', dec='.') #remember to set the doc on your working file
TW_corals

?read.table
library(tidyr)
TW_corals_long<-TW_corals%>%pivot_longer(Southern_TW:Northern_Is,names_to = "Region_TW", values_to = "Richness")
TW_corals_long

#to get the reverse 

TW_corals_wide<-pivot_wider(TW_corals_long, names_from = "Region_TW", values_from = "Richness")
TW_corals_wide

income<-read.table('metoo.txt', header=T, sep='\t', dec='.')
income

income_long<-income%>%pivot_longer(cols = -state,names_to = c('gender','work_type'),values_to = 'income',names_sep = '_')
income_long
#me dio error entonces hay que manually fix it
str(income)
income$male_other<-as.integer(income$male_other)
str(income)
income$female_other<-as.integer(income$female_other)
str(income)

#call the same code of the beg 
income_long<-income%>%pivot_longer(cols = -state,names_to = c('gender','work_type'),values_to = 'income',names_sep = '_')
income_long

#reverse pivot_wider
income_long %>% pivot_wider(names_from = c(gender,work_type), values_from = income, names_sep = '.')
str(income_long)

#splitting

# Let's first create a delimited table
income_long_var<-income %>%pivot_longer(cols = -1,names_to = 'var1',values_to = 'income')
head(income_long_var, 20)

# Split var1 column into two columns
income_sep<-income_long_var %>% separate(col = var1, sep = '_', into = c('gender','work'))
income_sep

#rows
#Split var1 into two rows
income_long_var %>% separate_rows(var1, sep = '_')
head(income_long)

##do exercise later//Practice 2.2##

##10/4 CLAS NOTES & SOLVING PRACTICE 2.2##

#loading library#
library(dplyr)
library(tidyr)

#preparing data, you can use the function read.table() too)

rairuho<- read.table("C:/Users/Andrea/Desktop/Rclass/week 4/rairuoho.txt", header = TRUE,sep="\t", dec=".")
head(rairuoho)
str(rairuoho)

#replacing "nutrient" with "enriched within treatment"
rairuoho_1<-rairuho %>% mutate(treatment= replace(treatment, treatment == "nutrient", "enriched")
head(rairuoho_1)

# reformatting 'day' as a single variable containig 6 levels
rairuho_2<-rairuoho_1%>%pivot_longer(day3:day8,names_to = "day", values_to= "length")
head(rairuoho_2)

#combining 2 columns (spatial1 and spatial2) into 1 column
rairuoho3<-rairuoho_2%>% unite("spatial coordinates", spatial1:spatial2, sep = "_")
head(rairuoho3)

#
rairuoho4<-dplyr::select(rairuoho4, -row, -column)

##"_" for italic "***" for bold

##start class week 4/ Data types and structures##
##c=combine

x <- c(1.0, -3.4, 2, 140.1) #numeric and double 
typeof(x)
mode(x)

##To force R to recognize a value as an integer 
#add an upper case L to the number.

x<- 4L
typeof(x)

x<-c("bubul", "magpie", "spoonbill", "barbet")
typeof(x)

x<- 3
y<- 5.3
x+y

plot(x,y)

#logical values can take 1 or 2 values/conditions: TRUE or FALSE
x <- c(TRUE, FALSE, FALSE, TRUE)
typeof(x)
x1<- c(1, 0, 0, 1)
x2<- as.logical(c(1, 0, 0, 1))

##factor##
#to group variables into categories aka in R "levels"

a <- c("M", "F", "F", "U", "F", "M", "M", "M", "F", "U")
typeof(x)

class(a) #number of categories
a.fact <-as.factor(a)
class(a.fact) #class factor
mode(a.fact)
typeof(a.fact)
a.fact

##see difference between just calling "a" and 'a.fact'
a #general
a.fact #more detailed

levels(a.fact)
str(a.fact) #check, the data is always represented in alphabetical order**

##the order in which the levels are displayed match their integer representation.

factor(a, levels = c("U", "F", "M"))

##Practice 3.1##

data("iris")
iris
iris.sel <- subset(iris, Species == "setosa" | Species == "virginica")
levels(iris.sel$Species)
str(iris.sel)

##versicolor still in the dataset despite the fact WE DONT WANT IT NO MORE
## So, we can use the function 'droplevel' and get rid of it

droplevels(iris.sel$Species)
iris.sel <-

##Date very important to know how your date is display
lubridate[see library (lubridate)]

##NAs and NULLs
#NULL mean it does not exist
#NA i need to specify whats the problem

x <- c(23, NA, 1.2, 5)
y< - c(23, NULL, 1.2, 5)
mean(x) #[1] NA
mean(x, na.rm = T) #here we specify what we want to do with NA 

mean(y)


##data structures##

#atomic vector (only used in coding) aka numeric value
#IMPORTANT: DONT FORGET "c()" to write values inside

x<- c(10, 30, 40, 1000, 5670)
x
x[3]

#you can combine multiple vectors
x[c(1,3,4)]

##you cannot mix numeric and character types as follows:
x<- c(1.2, 5, "Rt","2000") #it will show error

typeof(x)

##matrices and arrays
#matrices you cannot combine character and numeric

#datadrames you can combine!
                        #THIS WILL BE PART OF THE HW##

name<- c("a1", "b2", "b3")
value1 <- c(23, 4, 12)
value2 <- c(1, 45, 5)
dat <- data.frame(name, value1, value2)# list all the values in your dataset
dat
str(dat) ##always  after call structure after creating a dataset to see whether you have make mistakes
attributes(dat) #privides attributes
names(dat) #provides names of table
rownames(dat) #extract row names

#Lists

A <-data.frame( x = c(7.3, 29.4, 29.4, 2.9, 12.3, 7.5, 36.0, 4.8, 18.8, 4.2),
                y = c(5.2, 26.6, 31.2, 2.2, 13.8, 7.8, 35.2, 8.6, 20.3, 1.1))
# A= numeric=num
B <- c(TRUE, FALSE) #B= logical=logi
C <- c("apples", "oranges", "round") #c=character=chr
my.lst <- list (A=A, B=B, C=C)
my.lst
str(my.lst)
names(my.lst)
my.lst$A
my.lst[(1)] #1=A bc is the first element of my list
rownames(my.lst) #it gives NULL bc we didnt assign any names


#Coercing data (forced or converted)
#check more in the list under OCEAN5098

y   <- c("23.8", "6", "100.01","6")
y.c <- as.numeric(y)
y.c
as.integer(y)

## for the hw practice 3.2 
#i will have to use coerced date functions 

#######10/11########
#solving homework practice 3.2

#library always call it befoe coding!
install.packages("tidyverse")
library(tidyverse)

#dataset
before_diet <- c(104, 95, 87, 77, 112)
after_diet <- c(96, 91, 81, 75, 118)
data1 <- data.frame(before_diet, after_diet, row.names = paste('subject_', 1:5))

#data.frame(before_diet, after_diet, row.names = paste('subject_', 1:5))

#formatting

data2 <- data1 %>%
  pivot_longer(before_diet:after_diet, names_to = 'time', values_to = 'weight') %>%
  as.data.frame() #nice foramtting option
data2$time <-as.factor(data2$time)
str(data2) #chec typeof(data2$weight)

# list_1
subject <- rownames(data1)
weight_loss <- c((data1 [,2]-data_1 [,1])/data1[,1]*100)
weight_data <-data.frame(subject, weight_loss)
WEIGHT_LOSS <- list(subject=subject, weight_loss=weight_loss, weight_data=weight_data)
str(WEIGHT_LOSS)

#message
text <- "too easy"


##### CLASS GRAPHICS #####

?base
data("iris")
head(iris)
plot(iris$Petal.Length)
plot(iris$Petal.Width)

#scatterplot pairwise

plot(Petal.Length ~ Petal.Width, data = iris) 

#customization

plot(iris$Petal.Length ~ iris$Petal.Width) #using $ operator

# add labels to x- and y-axes, title 
plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal.Width (cm)',
     ylab = 'Petal.Lenght(cm)', 
     main ='Petal.Width & lenght of iris flower')

####ADDING COLOR WIII#### 
#plotting character= pch 
#see ?pch para entender mas
#character expansion cex

plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, #play with this to get familiar how to costumize your plot
     col = rgb (1,0,0,0.10)) #set its colors to be 90% 
#transparent (10% opaque) using col = rgb (0,0,0,0.10). #rgb red green blue

# create a vector of character with color names using "ifelse"

col.iris <- ifelse(iris$Species=='setosa', 'purple', ifelse(iris$Species=='versicolor', 'blue','pink')) 
col.iris

#the graphs with different colors assign in the code before
plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, 
     col = scales::alpha(col.iris, 0.2))

##adding legend to a plot

plot(Petal.Length ~ Petal.Width, data = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower', # main=graph title
     pch = 19, cex=2, 
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 19, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))

##The argument las=1 will rotate y-axis labels

plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     pch = 19, cex=2, las=1,
     col = scales::alpha((col.iris), 0.2))

legend(x="bottomright", pch= 19, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))
str(legend)
##The size of the main title, axis, labels is also control with cex arguments
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5,
     pch = 19, cex=2, las=1,
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 19, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))

## Finally the size of the points can be set as a proportion of a given continuous variable

ratio<-iris$Petal.Length/iris$Sepal.Width  # ratio between the length of petal and the width of Sepal
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5,
     pch = 19, las=1, cex= ratio * 2, 
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 19, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))

ratio<-iris$Petal.Length/iris$Sepal.Width  # ratio between the length of petal and the width of Sepal
plot(Petal.Length ~ Petal.Width, dat = iris,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5,
     pch = 19, las=1, cex= ratio * 2, 
     col = scales::alpha(col.iris, 0.2))

legend(x="bottomright", pch= 19, cex=1.0, legend= c("versicolor","setosa", "virginica"), col=levels(as.factor(scales::alpha(col.iris, 0.2))))

########### TYPES OF PLOTS ##################

#plane plot
#pairs allows a quick examination of the relationship among variables 
#that’s called a scatterplot matrix.

pairs(iris[1:4], pch = 19, col = scales::alpha(col.iris, 0.2))

#line plot
# generate a data frame with chronological variable

blossom <- NULL #it's typically good to start something empty and then you add elements after
blossom$year <- 2010:2019
blossom$count.alaska <- c(3, 1, 5, 2, 3, 8, 4, 7, 6, 9)
blossom$count.canada <- c(4, 6, 5, 7, 10, 8, 10, 11, 15, 17)
as.data.frame(blossom)

#let's create the line plot

plot(count.alaska ~ year, dat = blossom, type='l', #specifying the type of plot l=line
     ylab = "No. of flower blooming")

#to plot both point and line, b=both. plot symbol to pch=20

plot(count.alaska ~ year,dat = blossom, type='b', pch=20,
     ylab = "No. of flower blooming")

#customization
#We can rotate the axis, increase the width of the line, change its type and color:

plot(count.alaska ~year, dat = blossom, type='b', pch=20,
     lty=2, lwd=0.5, col= 'red',  #lty=line type
     ylab = "No. of flower blooming")

##add another line with the same customization

plot(count.alaska ~ year,dat = blossom, type='b', pch=20,
     lty=2, lwd=0.5, col='red',
     ylab = "No. of flower blossoming") 
lines(count.canada ~ year,dat = blossom, type='b', pch=20,
      lty=3, lwd=0.5, col='blue')

##### using the xlim and ylim parameters####

y.rng <-range(c(blossom$count.alaska, blossom$count.canada)) #only focus on the y-axis

plot(count.alaska ~year, dat= blossom, type='b', ylim = y.rng,
     lty=2, lwd=1, col='red',
     ylab='No. of flower blooming')
lines(count.canada ~ year, dat= blossom,
      lty=1, lwd=1, col='blue')

#using the points function instead of the lines function

iris.ver <- subset(iris, Species == 'versicolor')
iris.vir <- subset(iris, Species == 'virginica')

y.rng <- range( c(iris.ver$Petal.Length, iris.vir$Sepal.Length), na.rm = TRUE)#Note 1: that na.rm=T is added in the range function to prevent NA value in the data from returning an NA in the range.
x.rng <- range( c(iris.ver$Petal.Width, iris.vir$Sepal.Width), na.rm = TRUE)

#plot an empty plot
plot(Petal.Length ~ Petal.Width, dat = iris.ver,
     xlab = 'Petal width (cm)', 
     ylab = 'Petal length (cm)', 
     main = 'Petal width and length of iris flower',
     cex.axis=1.0, cex.lab=1.5, cex.main=1.5, type='n',
     xlim=x.rng,  ylim=y.rng)

# Add points for versicolor
points(Petal.Length ~ Petal.Width, dat = iris.ver, pch = 20,cex=2, 
       col = rgb(0,0,1,0.10))

# Add points for versicolor
points(Petal.Length ~ Petal.Width, dat = iris.vir, pch = 20,cex=2, 
       col =  scales::alpha('#fc03c6', 0.2)) #scales::alpha to add transparency effect to the plot

# Add legend #add name to the plots
legend("topleft", c("versicolor", "virginica"), pch = 19, cex=1.2,
       col = c(rgb(0,0,1,0.10), scales::alpha('#fc03c6', 0.2)))
#Note 2: You can define the color using the rgb function

##box plot graphical tools used to summarize the distribution of a data batch
#“box” that depicts the range covered by 50% of the data (aka the interquartile range, IQR
#a horizontal line that displays the median, and “whiskers” that depict 1.5 times the IQR or the largest (for the top half) or smallest (for the bottom half) values.

boxplot(iris$Sepal.Width, na.rm=TRUE)

#Several variables can be summarized on the same plot
boxplot(iris$Sepal.Width,iris$Sepal.Length, iris$Petal.Width,iris$Petal.Length, names = c("Sepal.Width", "Sepal.Length", "Petal.Length","Petal.Width"), main = "Iris flower traits")

#remove outliers when desire, outline parameter= FALSE

boxplot(iris$Sepal.Width,iris$Sepal.Length, iris$Petal.Width,iris$Petal.Length, names = c("Sepal.Width", "Sepal.Length", "Petal.Length","Petal.Width"), main = "Iris flower traits", outline = FALSE, horizontal = TRUE)

boxplot(Sepal.Width ~ Species,iris) 

#reordering the titles (main) in the plot

iris$Species.ord <- reorder(iris$Species,iris$Sepal.Width, median)
levels(iris$Species.ord)
boxplot(Sepal.Width ~ Species.ord, iris)

##HISTOGRAM PLOT## function "hist"

hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA)

#add  number of bins
hist(iris$Sepal.Width, xlab = "Width of Sepal", main = NA, breaks=10)

###ggplot### 
##practice 4.1 and 4.2#### DO IT!!!

############Mapping############dothe class and practice
#########Loops and Functions##############
#And practice 6.2## learn aout the equation too
## a type of animation(gifskin)  #ask Lioni

#############Statistics############# 11/1 week 7
#download statistics

#remember to install.package to call a function before writing 'library'

library (psych) #an even MORE detailed info >  function summary 
library(ggplot2) #for ggplot function
library(dplyr)
library(gridExtra) #for the grid.arrange function
library(car) # for leveneTest function

#Descriptive

# students data set url 
students<-read.table('https://www.dipintothereef.com/uploads/3/7/3/5/37359245/students.txt',header=T, sep="\t", dec='.') 
students
# to write it:
write.table(students, file = "Data/students.txt", sep = "\t", row.names=T)

summary(students) #for detailed info about your dataset
psych::describe(students) 
# * mean there's a prob on your data. ?help for more info

#mean, meadian, sd, etc

median(students$height)
ind.male <- students$gender == "male"
mean(students$height[ind.male])

#function apply and aggregate are very common
#when u use the function aggregate, YOU MUST HAVE A LIST 
#read more about the function "apply", this func can help you to avoid LOOPS, call it after you called the table

aggregate(students$height,list (students$gender),median)
tapply(students$height,students$gender, median)#tapply=

####################practice 7.1####################

#(1)
data("iris")
iris

plot1 <-ggplot(iris, aes(x=Species, y=Sepal.Length)) + 
  geom_boxplot()

plot2 <-ggplot(iris, aes(x=Species, y=Sepal.Length)) + 
  geom_boxplot()

plot3 <-ggplot(iris, aes(x=Species, y=Sepal.Length)) +
  geom_boxplot()

plot4 <-ggplot(iris, aes(x=Species, y=Sepal.Length)) +
  geom_boxplot()

install.packages("gridExtra") #no need to write again in the code bc its been installed
library(gridExtra)
grid.arrange(plot1, plot2, plot3, plot4, ncol=2)
describeBy (iris, iris$Species)

#(2)

iris %>% group_by(Species) %>% summarise(across(c(1:4), length))

#(3) calculating median by Sepal.Length

aggregate(iris[,1:4],by=list(iris$Species), median)
tapply(iris$Sepal.Length , iris$Species, mean)

#Hypothesis
#one of the objectives of stats is is hypothesis testing and something called The Null Hypothesis

# H0=null hypothesis, an absence of difference (does not mean there is no difference)
# H1= the alternative hypothesis - the presence of a difference
#degree of freedom, read more about it, link vid in class!

#Correlation 
#Pearson correlation - parametric

#dataset hypotheses?
data(students)
x <- students$height
y <- students$shoesize
s <-students [,1:2] # a matrix
# Pearson correlation
# cor(x,y)
# cor(s)
cor.test(x,y) # correlation test, by default is always a Pearson correlation

# represented with it confident interval on a scatter plot

ggplot(students, aes(x = height, y = shoesize)) + 
  geom_point() +
  stat_smooth(method = "lm", col = "green")

#Spearman correlation - non-parametric

# Spearman correlation (monotonic)
# cor(x,y, method ='spearman')


cor.test(x,y, method ='spearman')

#running both types of correlation

w<-(1:100)
z<-exp(x)
cor.test(w,z,method='pearson') # super low
cor.test(w,z,method='spearman') #super high

##### do practice 7.2

##########Chi-square test###############

#Cast 240 times a die. We counted occurrence of 1,2,3,4,5,6
die<-data.frame(obs=c(55,44,35,45,31,30), row.names=c('Cast1','Cast2','Cast3','Cast4','Cast5','Cast6'))
die #Is this die fair? Define H0 and H1.  

chisq.test(die)
#Chi-square test can simply be used to compare the distribution of frequencies in two populations:
#Hardy-Weinberg
# A common biological application of a Chi-square test is the Hardy-Weinberg equilibrium.

F <- matrix(nrow=4,ncol=2,data=c(33,14, 8,18,31,25,14,12))
chisq.test(F) # alternative see `fisher.test`
obs <- c(750, 50, 200)
exp <- c(0.60, 0.35, 0.05)
chisq.test (x=obs, p=exp)

#Student t-test

# One sample
t.test (students$height, mu=170)

# Two sample (with equal variances)
t.test (students$height~students$gender, var.equal = TRUE)

# Two sample (with unequal variances, default option when using t.test) 
t.test (students$height~students$gender)

# Two sample paired t.test
t.test (students$height~students$gender, paired=T)

## do practice 7.3

#Mann-Whitney Test
#A non-parametric solution for the comparison of two samples: Mann-Whitney U-test (independent) or Wilcoxon W-test (dependant)

# Normality plot & test
students$height[6]<-132
students$height[10]<-310
students$height[8]<-132
students$height[9]<-210
boxplot(height~gender, students)

qqnorm(students$height) 
qqline(students$height) 

shapiro.test(students$height) # data are not normal

#Variances
#used to determine if the variances of two (or more) populations are equal.

# Test of variance: we test HO: homogeneous, H1:heterogeneous
fligner.test (students$height ~ students$gender)

#using the ToothGrowth data set (car package) on multiple groups

tg<-ToothGrowth
tg$dose<-factor(tg$dose)
boxplot(len~dose*supp, data=tg)

# also work with: boxplot(len ~ interaction (dose,supp), data=tg)
# or: plot(len ~ interaction (dose,supp), data=tg)
bartlett.test(len~interaction (supp,dose),data=ToothGrowth) # sensitivity non-normality +++

install.packages("car")
library(car)
leveneTest(len~interaction (supp,dose),data=ToothGrowth) # sensitivity non-normality ++

fligner.test(len~interaction (supp,dose),data=ToothGrowth) # sensitivity non-normality +

######tarea  7.4
#tips for tarea
# 1 calculate t value first
# 2 compare with the student distribution

