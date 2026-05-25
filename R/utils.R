extract_emm_table <- function(model, time_filter = 2) {
  
  # Estimated marginal means
  emm_est <- emmeans(
    model,
    specs = ~ Group | Time
  )
  
  # Treatment vs Control contrasts
  emm_con <- contrast(
    emm_est,
    method = "trt.vs.ctrl",
    ref = "Control"
  )
  
  # Estimated means table
  est <- emm_est %>%
    as.data.frame() %>%
    select(Group, Time, emmean, lower.CL, upper.CL) %>%
    rename(
      Estimate = emmean
    )
  
  # Contrast table: Treatment - Control
  con <- emm_con %>%
    confint() %>%
    as.data.frame() %>%
    select(contrast, Time, estimate, lower.CL, upper.CL) %>%
    rename(
      Group = contrast,
      Estimate = estimate
    )
  
  # Final formatted table
  bind_rows(est, con) %>%
    mutate(
      across(where(is.numeric), ~ round(.x, 3))
    ) %>%
    mutate(
      CI = paste0("(", lower.CL, ", ", upper.CL, ")")
    ) %>%
    select(Group, Time, Estimate, CI) %>%
    filter(Time == time_filter)
}

format_gt_table <- function(gt_table) {
  
  gt_table |>
    tab_options(
      table.font.size = px(13),
      heading.title.font.size = px(16)
    )
}