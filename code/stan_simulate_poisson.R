# Stan-Poisson 响应变量为泊松分布

source(file = "simulate_data.R")
library(rstan)
library(brms)
# fit a multivariate gaussian process model
options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)
theme_set(theme_default())

########################### 响应变量服从泊松分布 ######################################
## 第一组参数
poiss_data_a1 <- sim_data(
  N = 49, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 1, sdgp = 1, cov.model = "exp_linear", type = "poisson"
)
poiss_data_a2 <- sim_data(
  N = 100, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 1, sdgp = 1, cov.model = "exp_linear", type = "poisson"
)

poiss_data_a3 <- sim_data(
  N = 225, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 1, sdgp = 1, cov.model = "exp_linear", type = "poisson"
)
fit.poiss_data_a1 <- brm(y ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  poiss_data_a1,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = poisson()
)

fit.poiss_data_a2 <- brm(y ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  poiss_data_a2,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = poisson()
)
fit.poiss_data_a3 <- brm(y ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  poiss_data_a3,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = poisson()
)

## 第二组参数
poiss_data_b1 <- sim_data(
  N = 49, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 5, sdgp = 4, cov.model = "exp_linear", type = "poisson"
)
poiss_data_b2 <- sim_data(
  N = 100, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 5, sdgp = 4, cov.model = "exp_linear", type = "poisson"
)
poiss_data_b3 <- sim_data(
  N = 225, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
  lscale = 5, sdgp = 4, cov.model = "exp_linear", type = "poisson"
)
fit.poiss_data_b1 <- brm(y ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  poiss_data_b1,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = poisson()
)

fit.poiss_data_b2 <- brm(y ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  poiss_data_b2,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = poisson()
)
fit.poiss_data_b3 <- brm(y ~ 0 + intercept + x1 + x2 + gp(d1, d2),
  poiss_data_b3,
  chains = 2, thin = 5, iter = 15000, warmup = 5000,
  algorithm = "sampling", family = poisson()
)

save.image(file = "data/poiss_simulate_stan.RData")

residuals(fit.binom_data_a1)
summary(fit.binom_data_a1)

posterior_summary(fit.binom_data_a1)
