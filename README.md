# Reproducible Clinical Reporting Workflow in R/Quarto

## Overview

This repository demonstrates a reproducible longitudinal clinical reporting workflow implemented in R and Quarto using simulated Parkinson’s disease observational data.

The project was designed to illustrate modern statistical reporting methodologies commonly used in pharmaceutical, biotechnology, and real-world evidence (RWE) environments, including:

- longitudinal mixed-effects modeling,
- sensitivity analyses for missing data,
- propensity score matching,
- automated statistical table generation,
- and reproducible HTML reporting workflows.

The workflow integrates statistical modeling, reporting automation, and reproducibility principles within a publication-style Quarto reporting framework.

---

## Methodologies Demonstrated

### Longitudinal Modeling
- Linear mixed-effects models using `lme4`
- Repeated measures longitudinal analysis
- Treatment-by-time interaction modeling
- Estimated marginal means and contrasts using `emmeans`

### Missing Data Sensitivity Analyses
- Illustrative reference-based imputation approach
- Missing-at-random (MAR) simulation framework
- Sensitivity analysis workflow structure

### Propensity Score Methodology
- Propensity score estimation using logistic regression
- Nearest-neighbor matching using `MatchIt`
- Covariate balance assessment using standardized mean differences
- Love plots using `cobalt`

### Automated Reporting
- Automated HTML report generation using Quarto
- Reproducible statistical tables using `gt` and `gtsummary`
- Programmatic figure generation
- Parameterized workflow structure

### Reproducibility
- Fully scripted analytical workflow
- Reproducible simulation framework
- Environment management using `renv`
- Version-controlled project architecture

---

## Technologies

- R
- Quarto
- Posit/RStudio
- tidyverse
- lme4
- lmerTest
- emmeans
- MatchIt
- cobalt
- gt
- gtsummary
- renv

---

## Repository Structure

```text
clinical-reporting-workflow-r-quarto/
│
├── README.md
├── _quarto.yml
├── index.qmd
├── renv.lock
├── .gitignore
│
├── R/
│   └── utility functions and reusable analysis code
│
├── data/
│   └── simulated datasets
│
├── docs/
│   └── rendered Quarto website output
│
├── figures/
│   └── exported figures
│
├── output/
│   └── rendered outputs and tables
│
└── references/
    └── methodology notes and supporting documentation
```

---

## Example Analyses Included

- Longitudinal UPDRS trajectory modeling
- Residual diagnostics
- Missingness visualization
- Sensitivity analyses for missing outcome data
- Propensity score matching and covariate balance diagnostics
- Automated statistical reporting tables
- Publication-style HTML reporting

---

## Reproducibility

This project uses a reproducible Quarto workflow in R.

All analyses, figures, tables, and statistical outputs are generated programmatically from simulated source data.

Random seeds were pre-specified for simulation and matching procedures to support computational reproducibility.

Package versions and analytical dependencies are managed using `renv`.

---

## Important Notes

- All data are simulated for methodological demonstration purposes only.
- This repository does not contain real clinical trial data.
- The project is intended as a statistical workflow demonstration and does not represent a regulatory submission analysis.
- Missing data sensitivity analyses are illustrative and do not fully implement regulatory-grade multiple imputation procedures.

---

## Professional Context

This repository reflects analytical and reporting approaches commonly used in:

- clinical development,
- biometrics,
- real-world evidence,
- statistical computing,
- and regulatory reporting environments.

The project was developed to demonstrate modern R-based reporting infrastructure and reproducible analytical workflows relevant to pharmaceutical and biotechnology clinical research settings.

---

## Author

Dean Leonardi, Ph.D.  
Principal Biostatistician

Experience includes:
- Phase I–IV clinical trials
- FDA/EMA submission support
- longitudinal modeling
- survival analysis
- CDISC environments
- real-world evidence methodologies
- automated statistical reporting workflows
- reproducible research infrastructure

---

## License

This repository is provided for educational and professional demonstration purposes.