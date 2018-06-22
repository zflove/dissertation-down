// generated with brms 2.3.2
// stancode(fit.binom_data_a1)
// make_stancode()
functions { 

  /* compute a latent Gaussian process
   * Args:
   *   x: array of continuous predictor values
   *   sdgp: marginal SD parameter
   *   lscale: length-scale parameter
   *   zgp: vector of independent standard normal variables 
   * Returns:  
   *   a vector to be added to the linear predictor
   */ 
  vector gp(vector[] x, real sdgp, real lscale, vector zgp) { 
    matrix[size(x), size(x)] cov;
    cov = cov_exp_quad(x, sdgp, lscale);
    for (n in 1:size(x)) {
      // deal with numerical non-positive-definiteness
      cov[n, n] = cov[n, n] + 1e-12;
    }
    return cholesky_decompose(cov) * zgp;
  }
} 
data { 
  int<lower=1> N;  // total number of observations 
  int Y[N];  // response variable 
  int trials[N];  // number of trials 
  int<lower=1> K;  // number of population-level effects 
  matrix[N, K] X;  // population-level design matrix 
  int<lower=1> Kgp_1; 
  int<lower=1> Mgp_1; 
  vector[Mgp_1] Xgp_1[N]; 
  int prior_only;  // should the likelihood be ignored? 
} 
transformed data { 
} 
parameters { 
  vector[K] b;  // population-level effects 
  // GP hyperparameters 
  vector<lower=0>[Kgp_1] sdgp_1; 
  vector<lower=0>[Kgp_1] lscale_1; 
  vector[N] zgp_1; 
} 
transformed parameters { 
} 
model { 
  vector[N] mu = X * b + gp(Xgp_1, sdgp_1[1], lscale_1[1], zgp_1); 
  // priors including all constants 
  target += student_t_lpdf(sdgp_1 | 3, 0, 10)
    - 1 * student_t_lccdf(0 | 3, 0, 10); 
  target += inv_gamma_lpdf(lscale_1 | 5.284601, 1.41864); 
  target += normal_lpdf(zgp_1 | 0, 1); 
  // likelihood including all constants 
  if (!prior_only) { 
    target += binomial_logit_lpmf(Y | trials, mu); 
  } 
} 
generated quantities { 
}
