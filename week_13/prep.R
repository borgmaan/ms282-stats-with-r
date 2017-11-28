

x <- rnorm(25)
y <- rnorm(25)
cor(x, y)


x <- rnorm(25)
y <- rnorm(25)
cor(x, y, method = 'spearman')

xr <- rank(x)
yr <- rank(y)
cor(xr, yr)


tread <- foreign::read.spss('Treadmill.sav')
t2 <- do.call(cbind, tread[1:3])
write.csv(t2, 'treadmill.csv', row.names = FALSE)


tread <- read.csv('treadmill.csv')



miles <- foreign::read.spss('2008 car data.sav')
tmp <- do.call(cbind, miles[1:2])
write.csv(tmp, 'miles.csv', row.names = FALSE)




