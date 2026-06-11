# Reproducible Clinical Reporting Workflow in R/Quarto

## Overview

This repository demonstrates a two-module reproducible clinical reporting workflow implemented in R and Quarto, spanning longitudinal CNS trial methodology and oncology real-world evidence (RWE) survival analysis.

**Module 1 — Longitudinal Clinical Trials (CNS/Parkinson's):** Linear mixed-effects modeling, MAR multiple imputation with Rubin's Rules, and propensity score matching applied to simulated Parkinson's disease observational data.

**Module 2 — Oncology RWE + Causal Forest:** Risk-set adjusted Kaplan–Meier estimation with median OS table, multivariable Cox PH with Schoenfeld diagnostics and forest plot, inverse probability weighting (IPW) for the ATE with sandwich SE, doubly robust AIPW estimation, E-value sensitivity analysis for unmeasured confounding, and causal forest for heterogeneous treatment effects (individual CATEs, calibration, variable importance) — applied to a simulated oncology RCT with overall survival as the primary endpoint.

The workflow integrates rigorous statistical methodology, reporting automation, and reproducibility principles within a publication-style Quarto framework.

---

## Methodologies Demonstrated

### Module 1 — Longitudinal Modeling (CNS/Parkinson's)

#### Mixed-Effects Modeling

- Linear mixed-effects models using `lme4` and `lmerTest`
- Repeated measures analysis with treatment-by-time interaction
- Estimated marginal means and treatment contrasts at Year 2 using `emmeans`
- Intraclass correlation coefficient (ICC) computed from variance components (`VarCorr`) to quantify between-patient vs. within-patient variance and validate the mixed-model specification
- Convergence diagnostics: optimizer warnings surfaced in rendered output via `@optinfo$conv$lme4$messages`
- Four-panel residual diagnostics: residuals vs. fitted, Q-Q plot of marginal residuals, Q-Q plot of random-intercept BLUPs, and scale-location plot with loess smoother

#### Missing Data — MAR Multiple Imputation (MICE)

- Multiple imputation by chained equations (MICE) using the `mice` package
- Predictive mean matching (PMM) as the imputation method, preserving the empirical distribution of UPDRS scores and avoiding out-of-range imputed values
- M = 25 completed datasets generated with 15 convergence iterations
- Convergence assessed via trace plots of imputed variable means and standard deviations across iterations
- Per-imputation LMER models fitted on wide-to-long reshaped completed datasets
- Fixed effects pooled across imputed datasets via Rubin's Rules using `mice::pool()` and `broom.mixed`
- Treatment effect at Year 2 derived by pooling emmeans contrasts across imputed models, with the Barnard-Rubin (1999) degrees-of-freedom approximation applied to Satterthwaite df from each imputed model
- Fraction of Missing Information (FMI) reported to quantify uncertainty attributable to missing data
- Missingness patterns visualized using `naniar::vis_miss()`

#### Propensity Score Methodology

- Propensity score estimation using logistic regression
- Nearest-neighbor 1:1 matching using `MatchIt`
- Covariate balance assessed before and after matching using standardized mean differences (SMD) via `tableone`, formatted as `gt` tables
- Love plots for visual balance diagnostics using `cobalt`
- LMER model re-fitted on matched cohort with estimated marginal means at Year 2

#### Automated Reporting

- Automated HTML report generation using Quarto
- Reproducible statistical tables using `gt` and `gtsummary`
- Inline R expressions for dynamically rendered key results
- Parameterized `missing_rate` in YAML header enabling re-render under alternative missingness scenarios
- Programmatic figure generation with `ggplot2`

---

### Module 2 — Oncology RWE + Causal Forest

#### Survival Analysis

- Risk-set adjusted Kaplan–Meier curves by treatment arm with 95% CI ribbons using `ggsurvfit`
- At-risk table and log-rank test with p-value annotation
- Multivariable Cox PH model (trt + age + stage + ecog) using `survival`; ties handled via Efron approximation
- Schoenfeld residuals test for proportional hazards assumption (`cox.zph`, `ggcoxzph`)
- Forest plot of HRs with 95% CIs across all covariates (`ggforest`)

#### Causal Inference — IPW, AIPW, and Causal Forest

- Inverse probability of treatment weighting (IPTW) via `WeightIt`; propensity score model (trt ~ age + stage + ecog), estimand = ATE
- IPW-weighted Cox model with sandwich (robust) standard errors via `sandwich` and `lmtest` — consistent with regulatory RWE practice
- E-value sensitivity analysis for unmeasured confounding via `EValue`; quantifies the minimum confounder association strength required to explain away the observed treatment effect
- Doubly robust AIPW estimation: outcome models fit separately by treatment arm (OLS on RMST at 24 months) combined with propensity scores via the AIPW influence function; consistent if either the outcome or propensity score model is correctly specified
- Causal forest for heterogeneous treatment effects (HTE) via `grf`; covariates: age, stage, ECOG PS; num.trees = 2000; honest splitting enforced
- Individual conditional average treatment effects (CATEs) extracted via `predict(cf)$predictions`
- Precision medicine visualization: CATEs vs. age, colored by disease stage
- Average treatment effect (ATE) via `average_treatment_effect(cf, target.sample = "all")` — cross-validated against IPW and AIPW estimates
- Causal forest goodness-of-fit: `test_calibration(cf)` (regulatory awareness)
- Covariate importance: `variable_importance(cf)` — identifies which baseline factor drives treatment effect heterogeneity

---

## Statistical Output

### Module 1

| Output | Description |
|--------|-------------|
| Table 1 | Demographics and baseline characteristics by treatment group |
| Table 2 | Primary LMER — estimated marginal means at Year 2 |
| Table 2b | Variance components and intraclass correlation coefficient (ICC) |
| Table 3a | Missingness summary prior to imputation |
| Table 3b | Pooled fixed effects from MICE (Rubin's Rules) |
| Table 3c | Pooled treatment effect at Year 2 with FMI |
| Table 4 | Covariate balance before propensity score matching |
| Table 5 | Covariate balance after propensity score matching |
| Table 6 | LMER on matched cohort — estimated marginal means at Year 2 |
| Figure 1 | Longitudinal mean UPDRS profiles with 95% CIs by group |
| Figure 2 | Four-panel residual diagnostics: residuals vs. fitted, Q-Q of marginal residuals, Q-Q of random-intercept BLUPs, scale-location |
| Figure 3a | Missing data pattern (naniar vis_miss) |
| Figure 3b | MICE convergence trace plots |
| Figure 4 | Love plot — covariate balance before and after matching |

### Module 2

| Output | Description |
|--------|-------------|
| Figure 1 | Kaplan–Meier OS curves with at-risk table and log-rank p-value |
| Table 0 | Median OS with 95% CIs by treatment arm (Brookmeyer-Crowley) |
| Table 1 | Multivariable Cox PH model coefficients (exponentiated) |
| Figure 2 | Schoenfeld residuals — PH assumption diagnostic |
| Figure 3 | Forest plot — HRs with 95% CIs for all covariates |
| Table 2 | IPW-weighted Cox model HR with sandwich SE and E-value sensitivity |
| Table 2b | Doubly robust AIPW estimate — RMST difference at 24 months |
| Figure 4 | CATEs vs. age by stage — precision medicine scatter plot |
| Table 4 | Average treatment effect (causal forest) — RMST difference at 24 months |
| Table 5 | Causal forest calibration test |
| Table 6 | Causal forest variable importance |

---

## Technologies

**Core**
- R / Quarto / Posit RStudio
- `renv` — package version management

**Statistical Modeling**
- `lme4` — linear mixed-effects models
- `lmerTest` — Satterthwaite degrees of freedom and p-values for LMER
- `emmeans` — estimated marginal means and contrasts
- `survival` — Cox PH and Kaplan–Meier estimation
- `survminer` — survival plot utilities including `ggcoxzph` and `ggforest`
- `ggsurvfit` — risk-set adjusted KM curves with at-risk tables

**Missing Data**
- `mice` — multiple imputation by chained equations
- `broom.mixed` — tidy model extraction enabling `mice::pool()` with LMER objects
- `naniar` — missing data visualization

**Causal Inference & Propensity Score**
- `WeightIt` — IPTW propensity score weighting
- `sandwich` / `lmtest` — robust (sandwich) standard errors for IPW-weighted models
- `EValue` — E-value sensitivity analysis for unmeasured confounding
- `grf` — generalized random forests; causal forest for heterogeneous treatment effects (HTE), individual CATEs, calibration, variable importance
- `MatchIt` — propensity score estimation and nearest-neighbor matching
- `cobalt` — standardized mean differences and Love plots
- `tableone` — covariate balance tables with SMD

**Reporting & Tables**
- `gt` — publication-style statistical tables
- `gtsummary` — automated summary and demographics tables
- `tidyverse` — data manipulation and visualization (`ggplot2`, `dplyr`, `tidyr`)

---

## Repository Structure

```text
clinical-reporting-workflow-r-quarto/
│
├── README.md
├── _quarto.yml
├── index.qmd              # Module 1 — Longitudinal Clinical Trials (CNS/Parkinson's)
├── oncology_rwe.qmd       # Module 2 — Oncology RWE + Causal Inference
├── renv.lock              # Locked package versions
├── .gitignore
│
├── R/
│   ├── utils.R            # Reusable functions: extract_emm_table(), format_gt_table()
│   └── simulate_oncology.R  # Simulated oncology RCT dataset (n=400)
│
├── _freeze/               # Quarto frozen computation cache
│
└── docs/                  # Rendered GitHub Pages output
```

---

## Reproducibility

All analyses, figures, tables, and statistical outputs are generated programmatically from simulated source data. No manual editing of outputs occurs at any stage.

Key reproducibility features:

- Random seeds pre-specified for simulation and matching
- `mice` imputation seeded separately (`set.seed(2026)`) to isolate the matching and imputation stages
- Oncology dataset seeded via `set.seed(42)` in `R/simulate_oncology.R`
- Quarto chunk caching with upstream cache invalidation prevents stale cached results
- `renv.lock` records the exact package versions used at time of rendering
- Parameterized `missing_rate` (default 0.25) in Module 1 allows re-rendering under alternative missingness assumptions without editing code
- Rendered as a standard multi-asset GitHub Pages site (`embed-resources: false`); figures, tables, and supporting assets are served as separate files rather than inlined into a single HTML document, keeping the rendered output lightweight and compatible with GitHub Pages hosting

---

## Important Notes

- All data are simulated for methodological demonstration purposes only.
- This repository does not contain real clinical trial data.
- The project is intended as a statistical workflow demonstration and does not represent a regulatory submission analysis.
- MICE with predictive mean matching implements proper MAR multiple imputation with Rubin's Rules pooling. The MAR assumption itself — that missingness depends only on observed data — cannot be verified from the observed data. MNAR sensitivity analyses (e.g., reference-based methods via the `rbmi` package) would be required for regulatory-grade submissions.
- The IPW-weighted Cox model uses stabilized IPTW weights with sandwich SE, consistent with current regulatory RWE guidance. Formal AIPW (doubly robust) estimation via `AIPW` or `drtmle` would provide additional robustness for regulatory submissions.

---

## Professional Context

This repository reflects analytical and reporting approaches used in pharmaceutical, biotechnology, and real-world evidence settings, including:

- clinical development and biometrics,
- real-world evidence and health economics outcomes research (HEOR),
- regulatory statistical reporting (FDA/EMA submission environments),
- statistical computing and reproducible research infrastructure.

The project demonstrates proficiency in the full statistical programming stack: mixed-effects modeling, missing data methodology (MICE/Rubin's Rules), survival analysis, causal adjustment (propensity score matching, IPTW, and doubly robust AIPW), E-value sensitivity analysis, causal forest for heterogeneous treatment effects (grf), and automated reproducible reporting — implemented within a modern Quarto/R workflow consistent with current pharmaceutical and RWE industry practice.

---

## Author

**Dean Leonardi, Ph.D.**
Biostatistician — Principal / Associate Director level

[linkedin.com/in/dean-leonardi-b0b50b10](https://www.linkedin.com/in/dean-leonardi-b0b50b10/) | [github.com/DeanLeonardiStats](https://github.com/DeanLeonardiStats)

Experience includes Phase I–IV clinical trials across neuroscience, oncology, hematology, rare disease, cardiovascular, and real-world evidence settings; FDA/EMA regulatory submission support (BLA, NDA, PMA, 510(k)); ICH E9/E9(R1) estimands; CDISC SDTM/ADaM; longitudinal modeling; survival analysis; missing data methodology; meta-analysis; and automated statistical reporting workflows.

---

## License

This repository is provided for educational and professional demonstration purposes.
