####### R CLASS NOTES #######
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
