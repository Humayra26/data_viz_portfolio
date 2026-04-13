#Bio319 Worksheet 1 --> 26/01/26

1+3*10

x<- 10
y<- 20
z<-'thirty'

x*y

is.numeric(x) #to know if x is numeric
class(x) #to know what class x is

#creating logical variables
a<-TRUE
b<-FALSE

1<2

1>2

x>y

# <= less than or equal to
# >= is greater than or equal to
# == is equal to
# != is not equal to
  
# & means and
# | means or

1<2 & 1>0

1<2 | 1>0 #if one is true, it will say true for both (even if one is false)

x <- 12 / 3 > 3 & 5 ^ 2 < 25
y <- 12 / 3 > 3 | 5 ^ 2 < 25 | 1 == 2

x
y

z <- FALSE
z == TRUE

z

c <- 'The cake'
l <- 'A lie'

c==l
c!=l

myname <- 'Humayra'
nchar(myname) #to know how many characters are in myname

nchar(myname)<6 & myname!= 'James' & myname!= 'Janelle' & myname!= 'Jamil' | myname !='Jessica'

#scalars contain a single value, for example x<-1 or cheese<-'delicious'
#vectors contain multiple values in a single object and that's when we use the c() function

x <- c(1,2,3,4)
y <- c(FALSE, TRUE, FALSE, TRUE, FALSE)
z <- c('I', 'got', 'the', 'right','temperature', 'to', 'shelter', 'you', 'from', 'the', 'storm')

class (x) #numeric
class(y) #logical
class (z) #character

rep(x=c(1,2,3),times=3) #this will repeat 1,2,3 three times

?rep() #if you do question mark and then rep and then brackets then it will tell you more info about that function

rep(c('I','will','not','tell','lies'), times=100)

#5.1, repeat a 5 times and b 5 times and c 5 times
rep(c('a','b','c'), each=5)

seq (from=1, to=10)

seq (from=10, to=-2)

seq (from=1, to=101, by=10)

seq (from=10, to=15, by=0.5)

measurements<-seq(from=0, to=150, by=10)
measurements

1:3

3:9

12:-2

x<-c('a','b','c','d','e','f','g','h')

x[1] #this will give you a
x[5]#this will give you e
x[3:5]#this will give c, d and e

x<-c(1,2,3,4,5,6,7,8,9,8,7,6,5,4,3,2,1)
x>5

y<-x[x>5]
print(y)

a <- c(2,3,4,5,6,7,8,9,10,11,12,13,14,15)
b<-a[a<=7]
print(b)

c<- a%%3 == 0 #this will tell you the ones that are divisible by 3 with no remainder
print (c)

mat1.data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
mat1 <- matrix(mat1.data,
               nrow = 3,
               ncol = 3,
               byrow = TRUE)
mat1

mat1.data <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
mat1 <- matrix(mat1.data,
               nrow = 3,
               ncol = 3,
               byrow = FALSE)
mat1


mat2.data <- c('a','b','c','d','e','f','g','h','i','j','k','l')
mat2<-matrix(mat2.data,
             nrow=3,
             ncol=4,
             byrow=FALSE)
mat2

mat2[1,3] #means 1st row, 3rd column
mat2[,2] #means 2nd column only

mat2[3,4]
mat2[2:3,1]
mat2[2:3,]

df<-read.csv('NYTBestsellers.csv')
str(df) #structure of the dataframe

df[1:3, 2:5]

df[3,] #data from row 3 using subscript
df[1:5,'title'] #this gives the first 5 titles from the table because "title" is one of the headings in the table

hist(df$total_weeks) #histogram of the total weeks against frequency

df[1:5,'title']
df$title[1:5]
#both of these give the same, it gives you items 1-5 in the title column

#to create a new column and fill it all with "brilliant":
df$personal_rating<-rep('brilliant',times=nrow(df)) 
df$personal_rating #WOW IT WORKED

df$number_of_pages<-rep(c('100','200','300','400','500'), each=20)
df$number_of_pages

???? last bit of q6

# q9 create a vector of every even number between 1 and 100
e<-seq(2,100,by=2)
print (e)

#q10 create a vector of all the odd numbers between 1000 and 1500 that are divisible by 7
o<-seq((1000:1500%%7==0), by=2)
print(o) #???????

p<-seq(1001,1499, by=7)
print (p)

#q11
df<-read.csv('NYTBestsellers.csv')
str(df) #structure of the dataframe

TopSpotAtLeast10Weeks <-df$best_rank>=10
TopSpotAtLeast10Weeks

#q12
df<-read.csv('NYTBestsellers.csv')
df2<-df[df$total_weeks <= 10 & nchar(df$title)<15,]
df2

#q13

df2$long10 <-'yes'
df2$long10 [nchar(df2$title)!=10] <- 'no'
df2

#q14

finaldf <-df2 [, c('title','author','year','long10')]
finaldf


