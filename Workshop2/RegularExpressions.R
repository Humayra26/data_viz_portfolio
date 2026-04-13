#Regular Expression Test

sentence<- c('Hello', 'my','name','is','Humayra','and','I','love','chocolate','so','so','so','much.',"I'm",'sorry','that','I',"didn't",'bring','you','any.')

grep_out <-grep(pattern='so',x=sentence)
grep_out

grep_out2 <-grep(pattern ='^so$',x=sentence)
grep_out2