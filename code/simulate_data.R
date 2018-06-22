# 模拟空间广义线性混合效应模型 stan-SGLMM
sim_data <- function(N = 49, intercept = -1.0, slope1 = 1.0, slope2 = 0.5,
                     lscale = 1, sdgp = 1, cov.model = "exp_quad", type = "binomail") {
  # set.seed(2018)

  d <- expand.grid(
    d1 = seq(0, 1, l = sqrt(N)),
    d2 = seq(0, 1, l = sqrt(N))
  )
  D <- as.matrix(dist(d)) # 计算采样点之间的欧氏距离

  switch(cov.model,
    matern = {
      phi <- lscale
      corr_m <- matern(D, phi = phi, kappa = 2) 
	  # corr_m <- geoR::matern(D, phi = phi, kappa = 2) # kappa = 2 固定的
	  # PrevMap::matern.kernel
      m <- sdgp^2 * corr_m
    },
    exp_quad = {
      phi <- 2 * lscale^2 # 二次幂指数核函数 kappa = 2 
      m <- sdgp^2 * exp(-D^2 / phi) # 多元高斯分布的协方差矩阵
    },
    exp_linear = {
      phi <- 2 * lscale^2 # 指数核函数 kappa = 0.5 的梅隆函数
      m <- sdgp^2 * exp(- D / phi) # 多元高斯分布的协方差矩阵
    }
  )

  # powered.exponential (or stable)
  # rho(h) = exp[-(h/phi)^kappa] if 0 < kappa <= 2 此处 kappa 固定为 2
  S <- MASS::mvrnorm(1, rep(0, N), m)
  # 模拟两个固定效应
  x1 <- rnorm(N, 0, 1)
  x2 <- rnorm(N, 0, 4)
  switch(type,
    binomail = {
      units.m <- rep(100, N) # N 个 100
      pred <- intercept + slope1 * x1 + slope2 * x2 + S
      mu <- exp(pred) / (1 + exp(pred))
      y <- rbinom(N, size = 100, prob = mu) # 每个采样点抽取100个样本
      data.frame(d, y, units.m, x1, x2)
    },
    poisson = {
      pred <- intercept + slope1 * x1 + slope2 * x2 + S
      y <- rpois(N, lambda = exp(pred)) # lambda 是泊松分布的期望
      # Y ~ Possion(lambda) g(u) = ln(u) u = lambda = exp(g(u))
      data.frame(d, y, x1, x2)
    }
  )
}

matern <- function(u, phi, kappa){
	uphi <- u/phi # kappa 和 phi 都必须大于0
	uphi <- ifelse(u > 0, (((2^(-(kappa - 1))) / ifelse(0, Inf, gamma(kappa))) * (uphi^kappa) * besselK(x = uphi, nu = kappa)), 1)
	# uphi[u > 600 * phi] <- 0 # 比值大于600就设置为0
	return(uphi)
}
