library(knutar)
library(MASS)
library(dplyr)
library(ggplot2)
library(ggh4x)
library(scales)


create_figure <- function(d, mod, title) {
  fig <- ggplot()
  fig <- fig + theme_bw()
  fig <- fig + geom_point(data = d, aes(times, accel), shape = 1,
    color = "gray50")
  fig <- fig + ggtitle(title)
  fig <- fig + xlab(parse_format()("'Predictor'~X"))
  fig <- fig + ylab(parse_format()("'Response'~Y"))

  knots <- extract_knots(mod)

  fig <- fig + geom_vline(xintercept = knots$knots, linetype = "dashed")
  fig <- fig + geom_vline(xintercept = knots$Boundary.knots, linetype = "solid")

  fig <- fig + geom_line(aes(x = mod$data$times, y = mod$fitted.values),
    linetype = "solid", color = "black", size = 0.5)

  fig <- fig + force_panelsizes(rows = unit(3.5, "in"), cols = unit(7, "in"))

  return(fig)
}

d <- mcycle

boundary_knots <-c(quantile(d$times, .05), quantile(d$times, .95))

max_knots <- 5

suggested_cnt <- suggest_knotcount(d, accel, times, max_nknots = max_knots,
  boundary_knots = boundary_knots)
m0 <- model_by_count(d, accel, times, suggested_cnt$nknots,
  boundary_knots = boundary_knots)
m1 <- choose_splines(d, accel, times,  max_nknots = max_knots,
  boundary_knots = boundary_knots)$model

fig <- create_figure(d, m0, "quantiles")
plot(fig)

fig <- create_figure(d, m1, "ours")
plot(fig)

