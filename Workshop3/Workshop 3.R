for (i in 1:5) {  # create a for loop that runs 5 times (1 to 5)
  print(i)        # each time the for loop runs, print the value of i
}

x <- 0            # make a new scalar called x with a value of 0

for (i in 1:10) { # create a for loop that runs 10 times (1 to 10)
  x <- x + i      # within our for loop we are adding the value of i to the value of x
}

print(x)          # print x


x <- 0            # make a new scalar called x with a value of 0

for (i in 1:15) { # create a for loop that runs 10 times (1 to 10)
  x <- x + i      # within our for loop we are adding the value of i to the value of x
}

print(x)          # print x

x <- 0            # make a new scalar called x with a value of 0

for (hello in 1:10) { # create a for loop that runs 10 times (1 to 10)
  x <- x + hello      # within our for loop we are adding the value of i to the value of x
}

print(x)          # print x












#question 2.3, part 4

x <- 0            # make a new scalar called x with a value of 0

for (i in 10:20) { # create a for loop that runs 10 times (1 to 10)
  x <- x + i      # within our for loop we are adding the value of i to the value of x
  print(x^2)
  }


shrek_quote <- c('What', 'are', 'you', 'doing', 'in', 'my', 'swamp')
for (word in shrek_quote) {
  print(tolower(word))  
}

for (donkey in 1:length(shrek_quote)) {
  print(toupper(shrek_quote[donkey]))  
}

#question 3

output <- vector() # creates an empty vector that we can fill with values
input <- c('red', 'yellow', 'green', 'blue', 'purple')
for (i in 1:length(input)) {
  output[i] <- nchar(input[i])
}
print(output)

# Create the fruits vector
fruits <- c("apple", "tangerine", "kiwi", "banana")

# Create empty vector to store results
fruit_chars <- c()

# Loop through each fruit
for (i in 1:length(fruits)) {
  fruit_chars[i] <- paste(fruits[i], nchar(fruits[i]), sep = "_")
}

fruit_chars

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i > 5){
    print(i)
  }
}

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i < 5 & i %% 1 == 0){
    print(paste(i, ' is less than five and an integer.', sep = ''))
  }
}



nums <- c(11, 22, 33, -0.01, 25, 100000, 7.2, 0.3, -2000, 20, 17, -11, 0)
for(i in nums){
  if (i>10 & i%%2 ==0){
    print(paste(i, 'is more than 10 and is divisible by 2.', sep=' '))
  } else {
    print (paste(i, 'is not more than 10 or is not divisible by 2', sep=' '))
  }
}

#4.2

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i < 5 & i %% 1 == 0){
    print(paste(i, ' is less than five and an integer.', sep = ''))
  } else {
    print(paste(i, ' is not less than five or is not an integer (or both!).', sep = ''))
  }
}


#4.3

numbers <- c(1, 4, 7, 33, 12.1, 180000,-20.5)
for(i in numbers){
  if(i < 5 & i %% 1 == 0){
    print(paste(i, ' is less than five and an integer.', sep = ''))
  } else if(i < 5 & i %% 1 != 0){
    print(paste(i, ' is not an integer.', sep = ''))
  } else if(i >= 5 & i %% 1 == 0){
    print(paste(i, ' is not less than five.', sep = ''))
  } else {
    print(paste(i, ' is not less than five and is not an integer.', sep = ''))
  }
}


#my turn on q4.3


nums <- c(11, 22, 33, -0.01, 25, 100000, 7.2, 0.3, -2000, 20, 17, -11, 0)
for(i in nums){
  if (i>10 & i%%2 ==0){
    print(paste(i, 'is more than 10 and is divisible by 2.', sep=' '))
  } else if (i<3){
    print(paste(i, 'is less than 3', sep=' '))
  }else {
    print (paste(i, 'is not more than 10 or is not divisible by 2', sep=' '))
  }
}



#question 5 - while loops

x <- 0
while(x < 5){
  x <- x + 1
  print(paste('The number is now ', x, sep = ''))
}


x <- 1
while(x %% 5 != 0 | x %% 6 != 0 | x %% 7 != 0){
  x <- x + 1
}
print(paste('The lowest number that is a factor of 5, 6, 7 and 8 is ', x, sep = ''))


x <- 1
while(x < 10){
  x <- x - 1
  print(x)
}



x <- 0.999
while (x>0.5){
  x <- x^2
  print(x)
}


#question 6.1

powers <- function(x){
  y <- x ^ 2
  return(y)
}
powers(1)

powers (30)

powers (5189)

powers <- function(x){
  y <- x ^ 2
  z <- x ^ 3
  return(c( y, z))
}
powers(1)

powers(30)

powers(5189)

powers <- function(x, y = 2){
  z <- x ^ y
  return(z)
}
powers(3)

powers(3, 3)


words <- function(x){
  z <- "is the word"
  result <- paste(x, z)
  return(result)
}

print(words("Bird"))



words <- function(x, y = "is the word") {
  paste(x, y)
}
print(words("Bird"))


#question 7
#1)

nums <- c(1,1,3,5,8,13,21)
for(i in nums){
    print (paste(sqrt(i)))
}


#2)
quote<-c('I','love','eating','at','restaurants','with','my','family')
for (word in quote)
  if (nchar(word) < 4) {
    print("too short")
  } else if (nchar(word) <= 6) {
    print(word)
  } else {
    print("too long")
  }

#3)

garbled_film_quote <- c()

quote <- c('I','love','eating','at','restaurants','with','my','family')

for (word in quote) {
  if (nchar(word) < 4) {
    garbled_film_quote <- c(garbled_film_quote, "too short")
  } else if (nchar(word) <= 6) {
    garbled_film_quote <- c(garbled_film_quote, word)
  } else {
    garbled_film_quote <- c(garbled_film_quote, "too long")
  }}
  
print (garbled_film_quote)


#4)

month_converter <- function(month){
  months <- c('January','February','March',
              'April','May','June',
              'July','August','September',
              'October','November','December')
  return(grep(pattern = month, x = months))
}

month_converter("October")


#5)
month_converter <- function(month_vec){
  months <- month.name #Make vector with months using built-in constant
  output <- vector() #Empty vector
  for (i in 1:length(month_vec)) {
    output[i] <- grep(pattern = month_vec[i], x = months)
  }
  return(output)
}

month_converter(c('April','May'))
