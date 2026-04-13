#Worksheet 2
print('Hello world!')
print ('I am sentient machine')

1<2 & 3>=3

6/2 > 4

# 3.1 an introduction

sentence <- c('By','the','time','they', 'got', 'back,', 'the', 'lights', 'were', 'all', 'out', 'and', 'everybody', 'was', 'asleep.', 'Everybody,', 'that', 'is,', 'except', 'for', 'Guih', 'Kyom', 'the', 'dung', 'beetle.', 'He', 'was', 'wide', 'awake', 'and', 'on', 'duty,', 'lying', 'on', 'his', 'back', 'with', 'his', 'legs', 'in', 'the', 'air', 'to', 'save', 'the', 'world', 'in', 'case', 'the', 'heavens', 'fell.')

grep_out <- grep(pattern='the',x=sentence)
grep_out

sentence[grep_out]

grep_out <- grep(pattern='^the$',x=sentence)
grep_out

sentence[grep_out]

grep_out <- grep(pattern = '[A-Z]', x = sentence)
grep_out

grep_out2 <- grep(pattern = 'a.e', x = sentence)
sentence[grep_out2]

#3.3 Quantifiers

sentence[grep(pattern = 'e.?e', x = sentence)]


sentence[grep(pattern = 'e.*e', x = sentence)]


sentence[grep(pattern = 'e.+e', x = sentence)]
#check word doc for worksheet 2

#3.4 - The gsub() Function

gsub_out <- gsub(pattern = 'a.e', x = sentence, replacement = '!!!')
gsub_out

gsub_out2 <- gsub(pattern = 't', x = sentence, replacement = '?')
gsub_out2 #i did this myself, I replaced all the t's with ?


#3.5 - The Challenge

str(dung_beetles_v2)

#question3
species <- colnames(dung_beetles_v2)
species

#question4
grepout <- grep(pattern= 'C', x=species)
grepout

#question4 again because theres a mistake on the sheet
grepout2 <-grep(pattern="_r", x=species)  
grepout2

#question5, this is to replace Copis with Copris
CopisCopris <-gsub('Copis','Copris', x=species)
CopisCopris

#question6, this is replacing Microcopis with Microcopris
MM <-gsub('Microcopis','Microcopris',x=species)
MM

#question8, this is doing both in one command
both <- gsub ('Copis','Copris',
              gsub('Microcopis','Microcopris',
              x=species))

both

#or i could do

cols <- colnames(df)
cols <- gsub(pattern = "opis", replacement = "opris", x = species)
cols

#question9, replace the column names in your data set with your corrected ones

colnames(df)[3:length(colnames(df))] <- cols


