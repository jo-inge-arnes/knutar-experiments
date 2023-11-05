library(knutar)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpubr)
library(ggh4x)
library(scales)


create_figure <- function(d, mod, title) {
  fig <- ggplot()
  fig <- fig + theme_bw() +
    theme(
      panel.grid.major = element_blank(),  # Remove major grid lines
      panel.grid.minor = element_blank()   # Remove minor grid lines
    )
  fig <- fig + geom_point(data = d, aes(age.dec, nwsize), shape = 1, color = "gray60", size = 0.6)
  fig <- fig + ggtitle(title)
  fig <- fig + xlab("Age")
  fig <- fig + ylab("Network size")

  knots <- extract_knots(mod)

  fig <- fig + geom_vline(xintercept = knots$knots, linetype = "dashed", color = "gray40", size = 0.4)
  fig <- fig + geom_vline(xintercept = knots$Boundary.knots, linetype = "solid", size = 0.4)

  fig <- fig + geom_line(aes(x = mod$data$age.dec, y = mod$fitted.values), linetype = "solid", color = "gray20", size = 0.4)

  return(fig)
}

hpp.explore <- read.table("./explorepenguin_share_complete_cases.csv", sep=",", header=T)
hpp.explore %>% 
  mutate(age.years=2023-age, age.dec=age.years) -> d 

boundary_knots <-c(quantile(d$age.dec, .05), quantile(d$age.dec, .95))

max_knots <- 3

m0 <- model_by_count(d, nwsize, age.dec, max_knots,
  boundary_knots = boundary_knots)
m1 <- choose_splines(d, nwsize, age.dec,  max_nknots = max_knots, boundary_knots = boundary_knots)$model

fig_standard <- create_figure(d, m0, "Standard")
fig_ours <- create_figure(d, m1, "Ours")

fig_standard_compared <- ggarrange(fig_standard, fig_ours, nrow = 2, ncol = 1)

plot(fig_standard_compared)

#ggsave("example_figs/human_penguin.png", plot = fig_standard_compared, device = "png", height = 4.2/2, width = 8.4)

ggsave("example_figs/human_penguin.png", plot = fig_standard_compared, device = "png", height = 8/4*3, width = 8)

