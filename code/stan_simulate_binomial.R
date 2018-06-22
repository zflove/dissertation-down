# 模拟分析 Stan Binomial
# 同类的指数型自相关函数 不同的和
# 参数设置 第一组 lscale = 1, sdgp = 1 第二组  lscale = 5, sdgp = 4

# 采样点数目分别为 N  = 49  100  225

source(file = "simulate_data.R")
library(rstan)
library(brms)
# fit a multivariate gaussian process model
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)
theme_set(theme_default())

########################### 响应变量服从二项分布 ######################################
## 第一组参数
binom_data_a1 <- sim_data(
  N = 49, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 1, sdgp = 1, cov.model = "exp_linear", type = "binomail"
)

binom_data_a2 <- sim_data(
  N = 100, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 1, sdgp = 1, cov.model = "exp_linear", type = "binomail"
)

binom_data_a3 <- sim_data(
  N = 225, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 1, sdgp = 1, cov.model = "exp_linear", type = "binomail"
)

fit.binom_data_a1 <- brm(y | trials(units.m) ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  data = binom_data_a1,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = binomial()
)

fit.binom_data_a2 <- brm(y | trials(units.m) ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  data = binom_data_a2,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = binomial()
)

fit.binom_data_a3 <- brm(y | trials(units.m) ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  data = binom_data_a3,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = binomial()
)

## 第二组参数

binom_data_b1 <- sim_data(
  N = 49, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 5, sdgp = 4, cov.model = "exp_linear", type = "binomail"
)
binom_data_b2 <- sim_data(
  N = 100, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 5, sdgp = 4, cov.model = "exp_linear", type = "binomail"
)
binom_data_b3 <- sim_data(
  N = 225, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 5, sdgp = 4, cov.model = "exp_linear", type = "binomail"
)

fit.binom_data_b1 <- brm(y | trials(units.m) ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  data = binom_data_b1,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = binomial()
)

fit.binom_data_b2 <- brm(y | trials(units.m) ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  data = binom_data_b2,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = binomial()
)

fit.binom_data_b3 <- brm(y | trials(units.m) ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  data = binom_data_b3,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = binomial()
)

save.image(file = "data/binorm_simulate_stan.RData")
