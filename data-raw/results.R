# ---- Construct data frame of results ----
results <- tibble::tribble(
  ~run, ~lap, ~air_pressure_psi, ~time_seconds, ~subjective_speed, ~subjective_control, ~notes,
  1, 1, "25/28", 11.17, 4, 3, "Tires breaking traction",
  2, 2, "25/28", 11.17, 2, 2, NA,
  3, 3, "25/28", 11.18, 4, 4, NA,
  4, 4, "25/28", 11.06, 4, 2, NA,
  5, 5, "25/28", 10.87, 5, 4, "Tires breaking traction",
  6, 1, "18/20", 10.82, 3, 2, NA,
  7, 2, "18/20", 10.88, 3, 2, NA,
  8, 3, "18/20", 10.82, 4, 4, NA,
  9, 4, "18/20", 10.70, 3, 3, "Almost no breaking of traction",
  10, 5, "18/20", 10.85, 3, 4, NA,
  11, 1, "18/20", 11.08, 2, 1, "Almost crashed",
  12, 2, "18/20", 10.91, 3, 3, NA,
  13, 3, "18/20", 10.76, 4, 4, NA,
  14, 4, "18/20", 10.48, 4, 2, "Attached second corner hard",
  15, 5, "18/20", 10.69, 5, 3, "No brakes second corner",
  16, 1, "25/28", 10.79, 4, 3, NA,
  17, 2, "25/28", 10.80, 2, 2, "Went off line",
  18, 3, "25/28", 10.74, 2, 2, "Foot off last corner",
  19, 4, "25/28", 10.45, 4, 3, "Foot off last corner",
  20, 5, "25/28", 10.68, 3, 3, NA,
  21, 1, "25/28", 10.76, 5, 2, "No brakes, drifted every turn",
  22, 2, "25/28", 10.60, 3, 3, NA,
  23, 3, "25/28", 10.45, 2, 3, "Felt like last corner was slow",
  24, 4, "25/28", 10.96, 2, 2, NA,
  25, 5, "25/28", 10.51, 3, 3, NA,
  26, 1, "18/20", 10.77, 2, 2, "Breaking point felt predictable",
  27, 2, "18/20", 10.68, 3, 3, "Took half-pedal stroke out of last corner",
  28, 3, "18/20", 10.75, 3, 3, NA,
  29, 4, "18/20", 10.79, 3, 2, NA,
  30, 5, "18/20", 10.66, 3, 2, "Foot out last corner"
)

# ---- Write ----
usethis::use_data(results)
