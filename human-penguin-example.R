library(knutar)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggh4x)
library(scales)


create_figure <- function(d, mod, title) {
  fig <- ggplot()
  fig <- fig + theme_bw()
  fig <- fig + geom_point(data = d, aes(age.dec, nwsize), shape = 1,
    color = "gray50")
  fig <- fig + ggtitle(title)
  fig <- fig + xlab(parse_format()("'Age Dec'"))
  fig <- fig + ylab(parse_format()("'Nwsize'"))

  knots <- extract_knots(mod)

  fig <- fig + geom_vline(xintercept = knots$knots, linetype = "dashed")
  fig <- fig + geom_vline(xintercept = knots$Boundary.knots, linetype = "solid")

  fig <- fig + geom_line(aes(x = mod$data$age.dec, y = mod$fitted.values),
    linetype = "solid", color = "black", size = 0.5)

  fig <- fig + force_panelsizes(rows = unit(3.5, "in"), cols = unit(7, "in"))

  return(fig)
}

hpp.explore <- read.table("./explorepenguin_share_complete_cases.csv", sep=",", header=T)
hpp.explore %>% 
  mutate(age.years=2023-age, age.dec=age.years/10) -> d 

boundary_knots <-c(quantile(d$age.dec, .05), quantile(d$age.dec, .95))

max_knots <- 3

m0 <- model_by_count(d, nwsize, age.dec, max_knots,
  boundary_knots = boundary_knots)
m1 <- choose_splines(d, nwsize, age.dec,  max_nknots = max_knots, boundary_knots = boundary_knots)$model

fig <- create_figure(d, m0, "quantiles")
plot(fig)

fig <- create_figure(d, m1, "ours")
plot(fig)

