
## worker plot functions
## date range for the sparkline
mk_sparkline_range <- function() ISOdatetime(c(1980, 2016), c(1, 11), 1, 0, 0, 0, tz = "GMT")

dummyplot <- function() plot(1, 1, type = "p", axes = FALSE, xlab = "", ylab = "")

layout_m <- function() {
  tx <- textConnection(
    "1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3
    1,1,9,9,9,9,9,1,3,3,11,11,11,11,11,3
    1,1,9,9,9,9,9,1,3,3,11,11,11,11,11,3
    1,1,9,9,9,9,9,1,3,3,11,11,11,11,11,3
    1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3
    1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3
    1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3
    1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3
    1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3
    1,1,1,1,1,1,1,1,3,3,3,3,3,3,3,3
    2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4
    2,2,10,10,10,10,10,2,4,4,12,12,12,12,12,4
    2,2,10,10,10,10,10,2,4,4,12,12,12,12,12,4
    2,2,10,10,10,10,10,2,4,4,12,12,12,12,12,4
    2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4
    2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4
    2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4
    2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4
    2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4
    2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4
    5,5,5,5,5,5,5,5,7,7,7,7,7,7,7,7
    5,5,13,13,13,13,13,5,7,7,15,15,15,15,15,7
    5,5,13,13,13,13,13,5,7,7,15,15,15,15,15,7
    5,5,13,13,13,13,13,5,7,7,15,15,15,15,15,7
    5,5,5,5,5,5,5,5,7,7,7,7,7,7,7,7
    5,5,5,5,5,5,5,5,7,7,7,7,7,7,7,7
    5,5,5,5,5,5,5,5,7,7,7,7,7,7,7,7
    5,5,5,5,5,5,5,5,7,7,7,7,7,7,7,7
    5,5,5,5,5,5,5,5,7,7,7,7,7,7,7,7
    5,5,5,5,5,5,5,5,7,7,7,7,7,7,7,7
    6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8
    6,6,14,14,14,14,14,6,8,8,16,16,16,16,16,8
    6,6,14,14,14,14,14,6,8,8,16,16,16,16,16,8
    6,6,14,14,14,14,14,6,8,8,16,16,16,16,16,8
    6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8
    6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8
    6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8
    6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8
    6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8
    6,6,6,6,6,6,6,6,8,8,8,8,8,8,8,8")
  as.matrix(read.csv(tx, header=F))
}
textheadtail <- function(x, y) {
  xx <- c(head(x, 1), tail(x, 1))
  yy <- c(head(y, 1), tail(y, 1))
  points(xx, yy, pch=19, cex=0.3, col=c("grey","black"))
  text(xx, yy, label = round(yy, 1), pos=2, xpd=NA, cex=0.65, offset=0.2)
  
}
path2seg <- function(x) {
  ## this is a trick of array logic to generate paired indexes from a sequence
  head(suppressWarnings(matrix(x, nrow = length(x) + 1, ncol = 2, byrow = FALSE)), -2L)
}
segmentlines <- function(x, col, ...) {
  ind <- path2seg(seq(nrow(x)))
  segments(x[ind[,1], 1], x[ind[,1], 2], x[ind[,2], 1], x[ind[,2], 2], 
           col = col, ...)
}
sector_colour <- function(secname) {
  setNames(c("#7CAE00", "#00BFC4","#C77CFF", "#F8766D"), 
           c("Atlantic","Indian", "EastPacific","WestPacific"))[secname]
  
}
sector_name <- function(secname) {
  setNames(c("Atlantic","Indian","East\nPacific","West\nPacific"), 
           c("Atlantic","Indian", "EastPacific","WestPacific"))[secname]
}
decselect <- function(n) {
  stopifnot(length(n) == 1L)
  #c("1980-1992", "1991-2004","2002-2016")[n]
  c("1981-1990", "1990-1999","1999-2008", "2008-2016")[n]
}
do_density <- function(v, w = NULL) {
  the.his <- hist(v, breaks=50, plot = FALSE)
  multiplier <- (the.his$counts / the.his$density)[1]
  the.den <- density(v, from=min(v), to=max(v), weights = w)
  scl <- function(x) (x - min(x))/diff(range(x))
  the.den.df<- data.frame(x=the.den$x, y=scl(the.den$y))
  the.den.df <- the.den.df[the.den.df$x >= min(v) & the.den.df$x <= max(v),]
  the.den.df$y[the.den.df$y > 1] <- 1
  the.den.df
}