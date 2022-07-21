library(RCurl)
library(XML)
library(plotly)

news <- function(get_news) {
  xml.url <- "http://petronoticias.com.br/category/og/feed/"
  script  <- getURL(xml.url)
  doc     <- xmlParse(script)
  titles    <- c(xpathSApply(doc,'//item/title',xmlValue))
  descriptions    <- c(xpathSApply(doc,'//item/description',xmlValue))
  pubdates <- c(xpathSApply(doc,'//item/pubDate',xmlValue))
  link <- c(xpathSApply(doc,'//item/link',xmlValue))
  table <- data.frame(titles, descriptions, pubdates, link)
}

my_news <- news()


pic <- plot_ly(
  type = 'table',
  header = list(
    values = c(names(my_news)),
    align = c('left', rep('center', ncol(my_news))),
    line = list(width = 1, color = 'black'),
    fill = list(color = 'rgb(245, 170, 0)'),
    font = list(family = "Calibri", size = 14, color = "white")
  ),
  cells = list(
    values = rbind(
      t(as.matrix(unname(my_news)))
    ),
    align = c('left', rep('center', ncol(my_news))),
    line = list(color = "black", width = 1),
    fill = list(color = c('rgb(220, 190, 40)', 'rgba(228, 222, 249, 0.65)')),
    font = list(family = "Calibri", size = 10, color = c("black"))
  ))

pic