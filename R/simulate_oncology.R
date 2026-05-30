# simulate_oncology.R
set.seed(42)
n <- 400
data_onc <- data.frame(
  patid    = 1:n,
  trt      = rbinom(n, 1, 0.5),
  age      = round(rnorm(n, 62, 10)),
  stage    = sample(3:4, n, replace=TRUE),
  ecog     = sample(0:2, n, replace=TRUE),
  os_time  = rexp(n, rate=ifelse(rbinom(n,1,0.5)==1, 0.04, 0.07)),
  os_event = rbinom(n, 1, 0.75)
)

