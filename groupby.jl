# Following along with:
# https://dataframes.juliadata.org/stable/man/split_apply_combine/
#
# Outcomes:
# 1. Recognize the role of a grouping variable
# 1. Recognize grouping variable in a word problem
# 1. Correspondence between SQL and Data Frames
# 1. Connection between one way ANOVA models?
# 1. Example of ANOVA model as a grouped computation you might want to do.

# Could also go into connection between ML
# https://juliapackages.com/p/regression

# TODO: Plot

using GLM

ols = lm(@formula(PetalWidth ~ Species), iris)

combine(gdf, :PetalWidth => mean)
