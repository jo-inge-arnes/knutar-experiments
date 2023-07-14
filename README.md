# Knutar Experiments
This repository contains the code for generating data, running the experiments, and creating the figures accompanying the paper [Greedy Knot Selection Algorithm for Restricted Cubic Spline Regression](https://doi.org/10.21203/rs.3.rs-2708178/v1).

`example-curves.Rmd` generates figures illustrating ground truth, a_1,
and a_2 curves for a sample.

`knot-removal-figure.Rmd` generates figures showing the effect of removing
inner knots, comparison to standard approach, and how BIC scores are affected
by an increasing number of knots.

`updated-experiments.Rmd` contains the source code for the experiments.

# Data Availability 
Data can be generated from the R-code but are also available as files in this repository. There are two ready-made datasets. The first dataset is `experiment-results-2023-03-20-15-29-33`, stored in both Rds and CSV formats. This dataset contains the results for each sample. The second dataset is `experiment-results-sample-stats-2023-03-20-15-29-33`, also stored in both Rds and CSV formats. This dataset contains various statistics for the results per "ground truth"-function.

## CSV-files

* [experiment-results-2023-03-20-15-29-33.csv](https://github.com/jo-inge-arnes/knutar-experiments/blob/main/experiment-results-2023-03-20-15-29-33.csv)
* [experiment-results-sample-stats-2023-03-20-15-29-33.csv](https://github.com/jo-inge-arnes/knutar-experiments/blob/main/experiment-results-sample-stats-2023-03-20-15-29-33.csv)

## Rds-files

* [experiment-results-2023-03-20-15-29-33.Rds](https://github.com/jo-inge-arnes/knutar-experiments/blob/main/experiment-results-2023-03-20-15-29-33.Rds)
* [experiment-results-sample-stats-2023-03-20-15-29-33.Rds](https://github.com/jo-inge-arnes/knutar-experiments/blob/main/experiment-results-sample-stats-2023-03-20-15-29-33.Rds)
  
# Source Code for Package

Note that the code for the package described in the paper is in a separate publicly available repository, [knutar](https://github.com/jo-inge-arnes/knutar). This package must be built and imported/added to the `knutar-experiments` project for the experiments to run.
