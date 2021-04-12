set.seed(3)
n = 30
sep = 6

x1 = rnorm(n)
y1 = rnorm(n)

x2 = rnorm(n) + sep
y2 = rnorm(n) - sep

x3 = rnorm(n) + sep
y3 = rnorm(n)



plot(c(x1, x2, x3), (c(y1, y2, y3)))
