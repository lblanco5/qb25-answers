library(ggplot2)

coverage <- read.table('/Users/cmdb/qb25-answers/week11/genome_coverage.txt')
poisson <- read.table('/Users/cmdb/qb25-answers/week11/poisson.txt')
normal <- read.table('/Users/cmdb/qb25-answers/week11/normal.txt')

genome_length = 1000000

x_vals <- seq(0, nrow(poisson) - 1)
df <- data.frame(x = x_vals, poisson = poisson$V1, normal = normal$V1)

ggplot(coverage, aes(x = V1)) + 
  geom_histogram(bins=60) + 
  geom_line(data = df, aes(x = x, y = poisson), color = 'red') +
  geom_line(data = df, aes(x = x, y = normal), color = 'darkgreen')
labs(
  title = "Genome Coverage Distribution",
  x = "Coverage Depth",
  y = "Count (Number of Bases)",
  color = "Distribution"
) +
  theme_minimal()
ggsave("/Users/cmdb/qb25-answers/week11/10x_coverage.png", width = 8, height = 6)
