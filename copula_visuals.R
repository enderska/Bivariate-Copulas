# Figures Thesis
rm(list = ls())
# Chapter 3.2.1: 
# Random Draws from N(0,1)

X <- rnorm(50,0,1)
Y <- rnorm(50,0,1)
cor(X,Y) #0.2
cor(X,Y,m="kendall") #same

# Transform X and Y into S and T

S <- exp(X)
T <- exp(2*Y)
cor(S,T) #0
cor(S,T,m="kendall") #same

par(mfrow=c(1,2))
plot(X,Y)
plot(S,T)

# Transform into rank obs
M <- rank(X)
N <- rank(Y)
plot(M,N)

O <- rank(S)
P <- rank(T)
plot(O,P)

plot(M, N, xlab="Rank(X)", ylab="Rank(Y)")
plot(O, P, xlab="Rank(O)", ylab="Rank(P)")



################################## Chapter 3.3 Copulas
par(mfrow=c(2,3))

################################### Gaussian Copula ##########################################################
# Scatter plot (left) and density (middle) of bivariate Gaussian Copula, as well as the copula itself (right) for increasing parameter rho

# for rho=0.3

gaus.cop1 <- normalCopula(param=0.3, dim=2)
a <- rCopula(1000, gaus.cop1)

plot(a, main="scatter plot", xlab="u", ylab="v", cex=.5)
persp(gaus.cop1, dCopula, main="copula density", xlab="u", ylab="v", zlab=" ", sub= expression("Gaussian Copula with"~rho~ "= 0.3"))
persp(gaus.cop1, pCopula, main="copula", xlab="u", ylab="v", zlab=" ")

# with rho=0.9
gaus.cop2 <- normalCopula(param=0.8, dim=2)
b <- rCopula(1000,gaus.cop2)

plot(b, xlab="u", ylab="v", cex=.5)
persp(gaus.cop2, dCopula, xlab="u", ylab="v", zlab=" ", sub= expression("Gaussian Copula with"~rho~ "= 0.8"))
persp(gaus.cop2, pCopula, xlab="u", ylab="v", zlab=" ")

###########################################################################################################

################################### Student Copula ##########################################################
par(mfrow=c(2,3))

t.cop1 <- tCopula(param = 0.3, dim=2, df=4)
c <- rCopula(1000, t.cop1)

plot(c, main="scatter plot", xlab="u", ylab="v", cex=.5)
persp(t.cop1, dCopula, main="copula density", xlab="u", ylab="v", zlab=" ", sub= expression("Student-t Copula with"~rho~ "= 0.3,"~ upsilon ~ "= 4"))
persp(t.cop1, pCopula, main="copula", xlab="u", ylab="v", zlab=" ")


t.cop2 <- tCopula(param = 0.7, dim=2, df=10)
d <- rCopula(1000, t.cop2)

plot(d, xlab="u", ylab="v", cex=.5)
persp(t.cop2, dCopula, xlab="u", ylab="v", zlab=" ", sub= expression("Student-t Copula with"~rho~ "= 0.7,"~ upsilon ~ "= 10"))
persp(t.cop2, pCopula, xlab="u", ylab="v", zlab=" ")

###########################################################################################################

################################### Clayton Copula ########################################################
par(mfrow=c(2,3))

#theta = 4
clay.cop1 <- archmCopula(family="clayton", dim=2, param=2)
e <- rCopula(1000,clay.cop1)

plot(e, main="scatter plot", xlab="u", ylab="v", cex=.5)
persp(clay.cop1, dCopula, main="copula density", xlab="u", ylab="v", zlab=" ", sub= expression("Clayton Copula with"~theta~ "= 2"))
persp(clay.cop1, pCopula, main="copula", xlab="u", ylab="v", zlab=" ")
      
# theta = 12
clay.cop2 <- archmCopula(family="clayton", dim=2, param=12)
f <- rCopula(1000,clay.cop2)

plot(f, xlab="u", ylab="v", cex=.5)
persp(clay.cop2, dCopula, xlab="u", ylab="v", zlab=" ", sub= expression("Clayton Copula with"~theta~ "= 12"))
persp(clay.cop2, pCopula, xlab="u", ylab="v", zlab=" ")

################################### Gumbel Copula ########################################################
par(mfrow=c(2,3))

# theta = 2
gumbel.cop1 <- archmCopula(family="gumbel", dim=2, param=2)
g <- rCopula(1000,gumbel.cop1)
        
plot(e, main="scatter plot", xlab="u", ylab="v", cex=.5)
persp(gumbel.cop1, dCopula, main="copula density", xlab="u", ylab="v", zlab=" ", sub= expression("Gumbel Copula with"~theta~ "= 2"))
persp(gumbel.cop1, pCopula, main="copula", xlab="u", ylab="v", zlab=" ")

# theta = 12
gumbel.cop2 <- archmCopula(family="gumbel", dim=2, param=12)
h <- rCopula(1000,gumbel.cop2)

plot(g, xlab="u", ylab="v", cex=.5)
persp(gumbel.cop2, dCopula, xlab="u", ylab="v", zlab=" ", sub= expression("Gumbel Copula with"~theta~ "= 12"))
persp(gumbel.cop2, pCopula, xlab="u", ylab="v", zlab=" ")


################################### Frank Copula ########################################################

frank.cop1 <- archmCopula(family="frank", dim=2, param=-5)
i <- rCopula(1000,frank.cop1)

plot(i, main="scatter plot", xlab="u", ylab="v", cex=.5)
persp(frank.cop1, dCopula, main="copula density", xlab="u", ylab="v", zlab=" ", sub= expression("Frank Copula with"~theta~ "= -5"))
persp(frank.cop1, pCopula, main="copula", xlab="u", ylab="v", zlab=" ")
        
frank.cop2 <- archmCopula(family="frank", dim=2, param=12)
j <- rCopula(1000,frank.cop2)

plot(j, xlab="u", ylab="v", cex=.5)
persp(frank.cop2, dCopula, xlab="u", ylab="v", zlab=" ", sub= expression("Frank Copula with"~theta~ "= 12"))
persp(frank.cop2, pCopula, xlab="u", ylab="v", zlab=" ")


################################## Chapter 3.2.3

par(mfrow=c(1,3))

clay.cop1 <- archmCopula(family="clayton", dim=2, param=4)
x <- rCopula(1500,clay.cop1)
plot(x, xlab="X", ylab="Y", cex=.5)

t.cop1 <- tCopula(param = 0.9, dim=2, df=8)
y <- rCopula(1500, t.cop1)
plot(y, xlab="X", ylab="Y", cex=.5)

gumbel.cop1 <- archmCopula(family="gumbel", dim=2, param=3)
z <- rCopula(1500,gumbel.cop1)
plot(z, xlab="X", ylab="Y", cex=.5)