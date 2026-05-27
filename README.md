# Reproducible Clinical Reporting Workflow in R/Quarto

## Overview

This repository demonstrates a reproducible longitudinal clinical reporting workflow implemented in R and Quarto using simulated Parkinson's disease observational data.

The project illustrates modern statistical reporting methodologies used in pharmaceutical, biotechnology, and real-world evidence (RWE) environments, including:

- longitudinal mixed-effects modeling with estimated marginal means,
- multiple imputation by chained equations (MICE) under a missing-at-random (MAR) assumption with Rubin's Rules pooling,
- propensity score matching with covariate balance diagnostics,
- automated and reproducible statistical table and figure generation,
- and parameterized HTML reporting via Quarto.

The workflow integrates rigorous statistical methodology, reporting automation, and reproducibility principles within a publication-style Quarto framework.

---

## Methodologies Demonstrated

### Longitudinal Modeling

- Linear mixed-effects models using `lme4` and `lmerTest`
- Repeated measures analysis with treatment-by-time interaction
- Estimated marginal means and treatment contrasts at Year 2 using `emmeans`
- Residual diagnostics for model assessment

### Missing Data — MAR Multiple Imputation (MICE)

- Multiple imputation by chained equations (MICE) using the `mice` package
- Predictive mean matching (PMM) as the imputation method, preserving the empirical distribution of UPDRS scores and avoiding out-of-range imputed values
- M = 25 completed datasets generated with 15 convergence iterations
- Convergence assessed via trace plots of imputed variable means and standard deviations across iterations
- Per-imputation LMER models fitted on wide-to-long reshaped completed datasets
- Fixed effects pooled across imputed datasets via Rubin's Rules using `mice::pool()` and `broom.mixed`
- Treatment effect at Year 2 derived by pooling emmeans contrasts across imputed models, with the Barnard-Rubin (1999) degrees-of-freedom approximation applied to Satterthwaite df from each imputed model
- Fraction of Missing Information (FMI) reported to quantify uncertainty attributable to missing data
- Missingness patterns visualized using `naniar::vis_miss()`

### Propensity Score Methodology

- Propensity score estimation using logistic regression
- Nearest-neighbor 1:1 matching using `MatchIt`
- Covariate balance assessed before and after matching using standardized mean differences (SMD) via `tableone`, formatted as `gt` tables
- Love plots for visual balance diagnostics using `cobalt`
- LMER model re-fitted on matched cohort with estimated marginal means at Year 2

### Automated Reporting

- Automated HTML report generation using Quarto
- Reproducible statistical tables using `gt` and `gtsummary`
- Inline R expressions for dynamically rendered key results (treatment effect estimates, sample sizes)
- Parameterized `missing_rate` in YAML header enabling re-render under alternative missingness scenarios
- Programmatic figure generation with `ggplot2`

### Reproducibility

- Fully scripted analytical workflow — no manual steps
- Pre-specified random seeds for simulation (`set.seed(456)`) and propensity score matching (`set.seed(2026)`)
- Quarto chunk caching with cache invalidation tied to upstream data dimensions
- Environment and package version management using `renv`
- Version-controlled project architecture

---

## Statistical Output

The report produces the following tables and figures:

| Output | Description |
|--------|-------------|
| Table 1 | Demographics and baseline characteristics by treatment group |
| Table 2 | Primary LMER — estimated marginal means at Year 2 |
| Table 3a | Missingness summary prior to imputation |
| Table 3b | Pooled fixed effects from MICE (Rubin's Rules) |
| Table 3c | Pooled treatment effect at Year 2 with FMI |
| Table 4 | Covariate balance before propensity score matching |
| Table 5 | Covariate balance after propensity score matching |
| Table 6 | LMER on matched cohort — estimated marginal means at Year 2 |
| Figure 1 | Longitudinal mean UPDRS profiles with 95% CIs by group |
| Figure 2 | Residual diagnostics for primary mixed-effects model |
| Figure 3a | Missing data pattern (naniar vis_miss) |
| Figure 3b | MICE convergence trace plots |
| Figure 4 | Love plot — covariate balance before and after matching |

---

## Technologies

**Core**
- R / Quarto / Posit RStudio
- `renv` — package version management

**Statistical Modeling**
- `lme4` — linear mixed-effects models
- `lmerTest` — Satterthwaite degrees of freedom and p-values for LMER
- `emmeans` — estimated marginal means and contrasts

**Missing Data**
- `mice` — multiple imputation by chained equations
- `broom.mixed` — tidy model extraction enabling `mice::pool()` with LMER objects
- `naniar` — missing data visualization

**Propensity Score & Balance**
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
├── index.qmd              # Main analysis document
├── renv.lock              # Locked package versions
├── .gitignore
│
├── R/
│   └── utils.R            # Reusable functions: extract_emm_table(), format_gt_table()
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
- Quarto chunk caching with upstream cache invalidation prevents stale cached results
- `renv.lock` records the exact package versions used at time of rendering
- Parameterized `missing_rate` (default 0.25) allows re-rendering under alternative missingness assumptions without editing code
- Rendered as a standard multi-asset GitHub Pages site (`embed-resources: false`); figures, tables, and supporting assets are served as separate files rather than inlined into a single HTML document, keeping the rendered output lightweight and compatible with GitHub Pages hosting

---

## Important Notes

- All data are simulated for methodological demonstration purposes only.
- This repository does not contain real clinical trial data.
- The project is intended as a statistical workflow demonstration and does not represent a regulatory submission analysis.
- MICE with predictive mean matching implements proper MAR multiple imputation with Rubin's Rules pooling. The MAR assumption itself — that missingness depends only on observed data — cannot be verified from the observed data. MNAR sensitivity analyses (e.g., reference-based methods via the `rbmi` package) would be required for regulatory-grade submissions.

---

## Professional Context

This repository reflects analytical and reporting approaches used in pharmaceutical, biotechnology, and real-world evidence settings, including:

- clinical development and biometrics,
- real-world evidence and health economics outcomes research (HEOR),
- regulatory statistical reporting (FDA/EMA submission environments),
- statistical computing and reproducible research infrastructure.

The project demonstrates proficiency in the full statistical programming stack: mixed-effects modeling, missing data methodology (MICE/Rubin's Rules), causal adjustment (propensity score matching), and automated reproducible reporting — implemented within a modern Quarto/R workflow consistent with current pharmaceutical industry practice.

---

## Author

**Dean Leonardi, Ph.D.**
Biostatistician — Principal / Associate Director level

[linkedin.com/in/dean-leonardi-b0b50b10](https://www.linkedin.com/in/dean-leonardi-b0b50b10/) | [github.com/DeanLeonardiStats](https://github.com/DeanLeonardiStats)

Experience includes Phase I–IV clinical trials across neuroscience, oncology, hematology, rare disease, cardiovascular, and real-world evidence settings; FDA/EMA regulatory submission support (BLA, NDA, PMA, 510(k)); ICH E9/E9(R1) estimands; CDISC SDTM/ADaM; longitudinal modeling; survival analysis; missing data methodology; meta-analysis; and automated statistical reporting workflows.

---

## License

This repository is provided for educational and professional demonstration purposes.
