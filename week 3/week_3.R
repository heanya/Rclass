#########CLASS NOTES WEEK 3 9/27 bis########
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

##do exercise later


