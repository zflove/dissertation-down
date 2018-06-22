# http://gbi.agrsci.dk/~ofch/geoRglm/Intro/show.html

library(geoRglm)
## 1. Simulating data
set.seed(2018)
sim <- grf(grid = expand.grid(x = seq(1, 7, l = 7), y = seq(1, 7, l = 7)), cov.pars = c(0.1, 2))
sim$units.m <- rep(100, 49)
sim$data <- rbinom(49, size = rep(100, 49), prob = exp(sim$data) / (1 + exp(sim$data)))

## 2. Visualising the data
# plot(sim$coords, type = "n")
# text(sim$coords[, 1], sim$coords[, 2], format(sim$data), cex = 1.5)

## 3. Setting input options
sim.pr <- prior.glm.control(phi.discrete = seq(0.05, 3, l = 60))
sim.mcmc <- mcmc.control(S.scale = 0.1, phi.scale = 0.04, burn.in = 10000)

grid <- expand.grid(x = seq(1, 7, l = 51), y = seq(1, 7, l = 51))
run.sim <- binom.krige.bayes(sim, locations = grid, prior = sim.pr, mcmc.input = sim.mcmc)

## inspecting output 检查输出
names(run.sim)
names(run.sim$posterior)
names(run.sim$posterior$phi)
# 检测链条是否收敛 通常采用快速直观的图检验方法
# 用自相关系数 ACF 来看链条的平稳性 如果平稳，ACF表现为快速衰减的特征
# 如果不平稳，就不能用这组数据来估计参数，如 \beta_0 \beta_1 \beta_2 等
par(mfrow = c(2, 2), mar = c(2.3, 2.5, .5, .7), mgp = c(1.5, .6, 0), cex = 0.6)
plot(run.sim$posterior$phi$sample, type = "l")
acf(run.sim$posterior$phi$sample)
plot(run.sim$posterior$sim[1, ], type = "l")
acf(run.sim$posterior$sim[1, ])

## Predictions
##
names(run.sim$predictive)
