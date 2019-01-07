## APPROACH-1: Using rbenchmark library 

#Create an m x n matrix with replicate(m, rnorm(n)) with m=10 column vectors of n=10 elements each,
#constructed with rnorm(n), which creates random normal numbers.

m <- replicate(10, rnorm(10), simplify = "matrix")  
m

#	Then we transform it into a dataframe (thus 10 observations of 10 variables) 

m <- as.data.frame(m)
View(m)


# perform an algebraic operation on each element using a nested for loop: 
#at each iteration, every element referred by the two indexes is incremented by a sinusoidal function,
#compare the vectorized and non-vectorized form of creating the solution and report the system time differences.


library(rbenchmark)
benchmark(
  vect = as.vector(m),          # vecotrized form
  conc = (n <- as.vector(for (i in seq(nrow(m))) { 
    for (j in seq(ncol(m))) {   # nested for 
      print(2*sin(m[i, j]))  # performing algebraic function on each element
    }
  }))
)


## APPROACH-2:

#Vectorized form 
set.seed(100) 
#create matrix 
mat_1<- replicate(10,rnorm(10)) 
#transform into data frame 
df_1= data.frame(mat_1) 
df_1<- df_1 + 2*sin(0.75*pi) 
#non-vectorized form 
set.seed(100) 
#create matrix 
mat_1<- replicate(10,rnorm(10)) 
#transform into data frame 
df_1= data.frame(mat_1) 
for(i in 1:10){ 
  for(j in 1:10){ 
    df_1[i,j]<- df_1[i,j] + 2*sin(0.75*pi) 
    print(df_1) 
  } 
} 
#time difference 
system.time( 
  df_1[i,j]<- df_1[i,j] + 2*sin(0.75*pi) 
) 
system.time( 
  for(i in 1:10){ 
    for(j in 1:10){ 
      df_1[i,j]<- df_1[i,j] + 2*sin(0.75*pi) 
    } 
  } 
) 

