data(iris)
head(iris)


iris[100,]
head(iris$Species)
iris$Species[100:105]
iris[100:105, "Species"]

#Which function

iris$Species == "versicolor"
TF<- iris$Species =="versicolor"
which(TF)
length(which(TF))
iris[which(iris$Species=="versicolor"),]
iris[(iris$Species=="versicolor"),]


# functions on certain variables

short_sepal_versa_ind <- which((iris$Sepal.Length < median(iris$Sepal.Length)) 
                                 (iris$Species == "versicolor"))


mean(iris$Sepal.Width[short_sepal_versa_ind])

#applies a summarizing function to subsets of our data-> 
#Leave as little room for user error by manually calculating and concatonating

by(iris$Sepal.Width, INDICES= iris$Species, FUN=mean)

by(iris$Sepal.Length, INDICES= iris$Species, median)

#Hadley Wickham- how data should be cleaned up and manipulated
#Two packages for R: tidyr and dplyr

#Talking mainly about dplyr:
#7 commands, piping operator using %>% easier to use and combine fxns
install.packages("dplyr")

#Loading packages Library command loads a library again (must be done each time):
library(dplyr)

#select fxn helps to only look at a subset of data from your set

head(iris %>% select(Sepal.Width, Species))

iris %>% select(Sepal.Width, Species) %>% head()


filter(select(iris, Sepal.Width, SPecies, Species ))


# Filter command with piping
iris %>% select(Sepal.Width, Species) %>% 
  filter(Species== "versicolor") %>%
  head()

#Sumarise command
iris %>%
  select(Sepal.Width, Species) %>%
  filter(Species == "versicolor") %>%
  summarise(mean.sepal.width = mean(Sepal.Width))


#group by 

iris %>%
  select(Sepal.Width, Species) %>%
  group_by(Species) %>%
  summarise(mean.sepal.width = mean(Sepal.Width))

#arrange fxn
iris %>%
  select(Sepal.Width, Species) %>%
  arrange(Sepal.Width) %>%
  summarise(tenth.largest = Species[length(Sepal.Width)-10])



iris %>%
  group_by(Species) %>%
  summarize(mean.sep.wid = mean(Sepal.Width),
            mean.sep.len = mean(Sepal.Length)) %>%
  arrange(mean.sep.wid)


#Join command is amazing... didn't go over it much
#mutate adds a new column
#How many flowers of there are of each species?

iris %>% 
  group_by(Species) %>%
  count(Species)

#noah's answer

iris %>% select(Species, Sepal.Width)%>%
  group_by(Species)%>%
  summarise(number= length(Sepal.Width))

##How many flowers are there with Sepal.Width 
#greater than the overall mean? Q3 and how many in each species?

iris %>% select(Species, Sepal.Width) %>%
  filter(Sepal.Width > mean(Sepal.Width) %>%
          group_by(Species)%>%
          summarise(number = n())
  
#not working right now.... urgh

